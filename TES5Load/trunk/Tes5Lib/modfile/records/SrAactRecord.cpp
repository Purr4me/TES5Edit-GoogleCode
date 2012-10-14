/*===========================================================================
 *
 * File:		SrAactRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srAactrecord.h"


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrAactRecord, CSrIdRecord)
END_SRSUBRECCREATE()

DEFINE_SRALLOCATOR(CSrAactRecord)
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrAactRecord, CSrIdRecord)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAactRecord Constructor
 *
 *=========================================================================*/
CSrAactRecord::CSrAactRecord ()
{
}
/*===========================================================================
 *		End of Class CSrAactRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAactRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrAactRecord::Destroy (void) 
{
	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrAactRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAactRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrAactRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();
}
/*===========================================================================
 *		End of Class Method CSrAactRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAactRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAactRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	//else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrAactRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrAactRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrAactRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrAactRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAactRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAactRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAactRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAactRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrAactRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrAactRecord Set Field Methods
 *=========================================================================*/
