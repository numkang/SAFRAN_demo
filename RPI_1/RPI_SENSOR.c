#include <stdio.h>
#include <stdlib.h>
#include <phidget22.h>
#include "PhidgetHelperFunctions.h"


/**
* Configures the device's DataInterval and ChangeTrigger.
* Displays info about the attached phidget channel.
* Fired when a Phidget channel with onAttachHandler registered attaches
*
* @param ph The Phidget channel that fired the attach event
* @param *ctx Context pointer
*/

char chan = '1';
int itr = 0;
double output_voltage = 0;

static void CCONV onAttachHandler(PhidgetHandle ph, void *ctx) {
	PhidgetReturnCode prc;
	int32_t serialNumber;
	PhidgetHandle hub;
	int32_t hubPort;
	int32_t channel;

	/*
	*	Set the DataInterval inside of the attach handler to initialize the device with this value.
	*	DataInterval defines the minimum time between VoltageRatioChange events.
	*	DataInterval can be set to any value from MinDataInterval to MaxDataInterval.
	*/
	// printf("\tSetting DataInterval to 100ms\n"); //smaller number, the faster output data
	prc = PhidgetVoltageRatioInput_setDataInterval((PhidgetVoltageRatioInputHandle)ph, 10);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Set DataInterval: \n\t");
		DisplayError(prc);
		return;
	}

	/*
	*	Set the VoltageRatioChangeTrigger inside of the attach handler to initialize the device with this value.
	*	VoltageRatioChangeTrigger will affect the frequency of VoltageRatioChange events, by limiting them to only occur when
	*	the ratio changes by at least the value set.
	*/
	// printf("\tSetting VoltageRatio ChangeTrigger to 0.0\n");
	prc = PhidgetVoltageRatioInput_setVoltageRatioChangeTrigger((PhidgetVoltageRatioInputHandle)ph, 0.0);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Set VoltageRatioChangeTrigger: \n\t");
		DisplayError(prc);
		return;
	}

	prc = Phidget_getDeviceSerialNumber(ph, &serialNumber);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Get DeviceSerialNumber: \n\t");
		DisplayError(prc);
		return;
	}

	prc = Phidget_getChannel(ph, &channel);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Get Channel: \n\t");
		DisplayError(prc);
		return;
	}

	//Check if this is a VINT device
	prc = Phidget_getHub(ph, &hub);
	if (EPHIDGET_WRONGDEVICE != prc) {
		prc = Phidget_getHubPort(ph, &hubPort);
		if (EPHIDGET_OK != prc) {
			fprintf(stderr, "Runtime Error -> Get HubPort: \n\t");
			DisplayError(prc);
			return;
		}
		printf("\n[Attach Event]:\n\t-> Serial Number: %d\n\t-> Hub Port: %d\n\t-> Channel %d\n\n", serialNumber, hubPort, channel);
	}
	else {
		//printf("\nAttach Event:\n\t-> Serial Number: %d\n\t-> Channel %d\n\n", serialNumber, channel);
	}
}

/**
* Displays info about the detached phidget channel.
* Fired when a Phidget channel with onDetachHandler registered detaches
*
* @param ph The Phidget channel that fired the detach event
* @param *ctx Context pointer
*/
static void CCONV onDetachHandler(PhidgetHandle ph, void *ctx) {
	PhidgetReturnCode prc;
	PhidgetHandle hub;
	int serialNumber;
	int hubPort;
	int channel;

	prc = Phidget_getDeviceSerialNumber(ph, &serialNumber);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Get DeviceSerialNumber: \n\t");
		DisplayError(prc);
		return;
	}

	prc = Phidget_getChannel(ph, &channel);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Get Channel: \n\t");
		DisplayError(prc);
		return;
	}

	//Check if this is a VINT device
	prc = Phidget_getHub(ph, &hub);
	if (EPHIDGET_WRONGDEVICE != prc) {
		prc = Phidget_getHubPort(ph, &hubPort);
		if (EPHIDGET_OK != prc) {
			fprintf(stderr, "Runtime Error -> Get HubPort: \n\t");
			DisplayError(prc);
			return;
		}
		printf("\nDetach Event:\n\t-> Serial Number: %d\n\t-> Hub Port: %d\n\t-> Channel %d\n\n", serialNumber, hubPort, channel);
	}
	else {
		printf("\nDetach Event:\n\t-> Serial Number: %d\n\t-> Channel %d\n\n", serialNumber, channel);
	}
}

/**
* Writes phidget error info to stderr.
* Fired when a Phidget channel with onErrorHandler registered encounters an error in the library
*
* @param ph The Phidget channel that fired the error event
* @param *ctx Context pointer
* @param errorCode the code associated with the error of enum type Phidget_ErrorEventCode
* @param *errorString string containing the description of the error fired
*/
static void CCONV onErrorHandler(PhidgetHandle phid, void *ctx, Phidget_ErrorEventCode errorCode, const char *errorString) {

	fprintf(stderr, "[Phidget Error Event] -> %s (%d)\n", errorString, errorCode);
}

/**
* Sets the event handlers for Phidget Attach, Phidget Detach, Phidget Error events
*
* @param ph The Phidget channel to add event handlers to
* @return 0 if the operation succeeds, 1 if it fails
*/
int SetAttachDetachError_Handlers(PhidgetHandle ch) {
	PhidgetReturnCode prc;
	// printf("\n--------------------------------------\n");
	// printf("\nSetting OnAttachHandler...\n");
	prc = Phidget_setOnAttachHandler(ch, onAttachHandler, NULL);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Set Attach Handler: \n\t");
		DisplayError(prc);
		return 1;
	}

	// printf("Setting OnDetachHandler...\n");
	prc = Phidget_setOnDetachHandler(ch, onDetachHandler, NULL);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Set Detach Handler: \n\t");
		DisplayError(prc);
		return 1;
	}

	// printf("Setting OnErrorHandler...\n");
	prc = Phidget_setOnErrorHandler(ch, onErrorHandler, NULL);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Set Error Handler: \n\t");
		DisplayError(prc);
		return 1;
	}

	return 0;
}

/**
* Outputs the VoltageRatioInput's most recently reported ratio.
* Fired when a VoltageRatioInput channel with onVoltageRatioChangeHandler registered meets DataInterval and ChangeTrigger criteria
*
* @param pvrih The VoltageRatioInput channel that fired the VoltageRatioChange event
* @param *ctx Context pointer
* @param ratio The reported voltage ratio from the VoltageRatioInput channel
*/

void print_data(){
	extern char chan;
	extern double output_voltage;	
	printf("Output: %.12f V on channel: %c\n", output_voltage, chan);
	
}

static void CCONV onVoltageRatioChangeHandler(PhidgetVoltageRatioInputHandle pvrih, void *ctx, double ratio) {
	
	// extern char chan;
	extern double output_voltage;
	extern int itr;
	itr++;
	output_voltage = ratio;
	
	// printf("[VoltageRatio Event] -> Ratio: %.12f on channel: %c\n", ratio, chan);
	print_data();
}

/**
* Creates a new instance of a VoltageRatioInput channel.
*
* @param pvrih Pointer to the PhidgetVoltageRatioInputHandle channel to create
* @return 0 if the operation succeeds, 1 if it fails
*/
static int CreateVoltageRatioInput(PhidgetVoltageRatioInputHandle *pvrih) {
	PhidgetReturnCode prc;

	printf("Creating VoltageRatioInput Channel...\n");
	prc = PhidgetVoltageRatioInput_create(pvrih);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Creating VoltageRatioInput: \n\t");
		DisplayError(prc);
		return 1;
	}
	return 0;
}

/**
* Sets the event handler for VoltageRatioInput's VoltageRatioChange event
*
* @param pvrih The PhidgetVoltageRatioInputHandle channel to add the event to
* @param fptr The callback function to be called when a VoltageRatioChange event is fired
* @return 0 if the operation succeeds, 1 if it fails
*/
static int SetVoltageRatioHandler(PhidgetVoltageRatioInputHandle pvrih, PhidgetVoltageRatioInput_OnVoltageRatioChangeCallback fptr) {
	PhidgetReturnCode prc;

	if (fptr) {
		/* printf("\n--------------------\n"
			"\n  | Voltage ratio change events contain the most recent voltage ratio received from the device.\n"
			"  | The linked VoltageRatioChange function will run as an event at every DataInterval.\n"
			"  | These events will not occur until a change in ratio >= to the set ChangeTrigger has occured.\n"
			"  | DataInterval and ChangeTrigger should initially be set in the device AttachHandler function.\n");*/
	}
	printf("\n%s OnVoltageRatioChangeHandler...\n", (fptr ? "Setting" : "Clearing"));
	printf("\n--------------------\n");
	prc = PhidgetVoltageRatioInput_setOnVoltageRatioChangeHandler(pvrih, fptr, NULL);
	if (EPHIDGET_OK != prc) {
		fprintf(stderr, "Runtime Error -> Setting VoltageRatioChangeHandler: \n\t");
		DisplayError(prc);
		return 1;
	}
	return 0;
}

/**
* Creates, configures, and opens a VoltageRatioInput channel.
* Displays Voltage Ratio events for 10 seconds
* Closes out VoltageRatioInput channel
*
* @return 0 if the program exits successfully, 1 if it exits with errors.
*/
int main() {
	FILE *fp = fopen("sensor.txt","w");
	if(fp == NULL){
		printf("Error opening file");
	}
	
	PhidgetVoltageRatioInputHandle ch = NULL;

	/*
	 * Allocate a new Phidget Channel object
	 */

	if (CreateVoltageRatioInput(&ch))
		goto error;

	/*
	 * Set matching parameters to specify which channel to open
	 */

	if (SetSerialNumber((PhidgetHandle)ch)) // already set
		goto error;

	if (SetVINTProperties((PhidgetHandle)ch)) //not use
		goto error;
		
	if (SetupNetwork((PhidgetHandle)ch)) //not use
		goto error;

	extern char chan;
	if (SetChannel((PhidgetHandle)ch, chan))
		goto error;	

	/*
	 * Add event handlers before calling open so that no events are missed.
	 */

	if (SetAttachDetachError_Handlers((PhidgetHandle)ch))
		goto error;

	if (SetVoltageRatioHandler(ch, onVoltageRatioChangeHandler))
		goto error;

	/*
	 * Open the channel with a timeout
	 */

	if (OpenPhidgetChannel_waitForAttach((PhidgetHandle)ch, 5000))
		goto error;

	// printf("Sampling data for 10 seconds...\n");
	
	extern double output_voltage;
	extern int itr;
	while(1){
		// For switching between each channel
		//if(itr == 1){
			//itr = 0;
			//if(chan == '0'){
				//chan = '1';
				//ClosePhidgetChannel((PhidgetHandle)ch);
				//if (SetChannel((PhidgetHandle)ch, chan))
					//goto error;
				//if (OpenPhidgetChannel((PhidgetHandle)ch))
					//goto error;
			//}else if(chan == '1'){
				//chan = '0';
				//ClosePhidgetChannel((PhidgetHandle)ch);
				//if (SetChannel((PhidgetHandle)ch, chan))
					//goto error;
				//if (OpenPhidgetChannel((PhidgetHandle)ch))
					//goto error;				
			//}
		//}
		rewind(fp);
		fprintf(fp, "%.12f", output_voltage);
	};
	fclose(fp);
	
	//it should never reach this line
	
	//while(1);

	//Sleep(10000);

	/*
	 * Perform clean up and exit
	 */

	if (SetVoltageRatioHandler(ch, NULL))
		goto error;

	printf("\nDone Sampling...\n");

	printf("\nCleaning up...\n");
	ClosePhidgetChannel((PhidgetHandle)ch);
	PhidgetVoltageRatioInput_delete(&ch);
	printf("\nExiting...\n");
	printf("Press ENTER to end program.\n");
	getchar();

	return 0;

error:
	PhidgetVoltageRatioInput_delete(&ch);
	fprintf(stderr, "\nExiting with error(s)...\n");
	printf("Press ENTER to end program.\n");
	getchar();

	return 1;
}
