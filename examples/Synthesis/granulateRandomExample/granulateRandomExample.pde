/* granulateRandomExample<br/>
   is an example of using the GranulateRandom UGen inside an instrument.
   The GranulateRandom UGen is basically an amplitude modulation of the
   incoming audio, which turns on for a random amount of time and then off
   again for a random amount of time.  If one uses several of these concurrently
   it produces the "grain cloud" typical of granular synthesis.
   <p>
   For more information about Minim and additional features, visit http://code.compartmental.net/minim/
   <p>
   author: Anderson Mills<br/>
   Anderson Mills's work was supported by numediart (www.numediart.org)
*/

// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;

// setup is run once at the beginning
void setup()
{
  // initialize the drawing window
  size(512, 200, P2D);

  // initialize the minim and out objects
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO, 2048);
  // the note offsets are calculated because this makes composition easier
  
  // because there are so many calls to the granularInstrument, it becomes easier
  // to compose here by using variables for note parameters.  
  float myOffset = 0.5;
  float noteLen = 0.0;
  out.setNoteOffset( myOffset );
  
  // this starts with three GroanularInstruments all taking the same path
  float myTargetFreq = 660.9f;
  float vol = 0.2;
  noteLen = 4.5;
  out.playNote( 0.0, noteLen, new GrabularInstrument( vol, 440.0f, myTargetFreq ) );
  out.playNote( 0.1, noteLen, new GrabularInstrument( vol, 440.0f, myTargetFreq ) );
  out.playNote( 0.2, noteLen, new GrabularInstrument( vol, 440.0f, myTargetFreq ) );

  // set up the offset for the next note
  myOffset += noteLen;
  out.setNoteOffset( myOffset );
  
  // The next "note" will be nine GranularInstruments headed from the previous myTargetFreq
  // to the first 9 harmonics of 220Hz (220, 440, 660, ... )
  vol = 0.15;
  noteLen = 7.0;
  int nFreqs = 9;
  float myFreqs[] = new float[ nFreqs ];
  for ( int i=0; i<nFreqs; i++ )
  {
    //myFreqs[ i ] = random( 900 ) + 100.0;
    myFreqs[ i ] = i*220.0;
  }
  out.playNote( 0.00, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 0 ] ) );
  out.playNote( 0.05, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 1 ] ) );
  out.playNote( 0.10, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 2 ] ) );
  out.playNote( 0.15, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 3 ] ) );
  out.playNote( 0.20, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 4 ] ) );
  out.playNote( 0.25, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 5 ] ) );
  out.playNote( 0.30, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 6 ] ) );
  out.playNote( 0.35, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 7 ] ) );
  out.playNote( 0.40, noteLen, new GrabularInstrument( vol, myTargetFreq, myFreqs[ 8 ] ) );

  // set up the next note offset
  myOffset += noteLen;
  out.setNoteOffset( myOffset );
  
  // The next note will be 9 GranularInstruments going from their previous values to a
  // new myTargetFreq.
  myTargetFreq = 1320.9f;
  vol = 0.15;
  noteLen = 7.0;
  out.playNote( 0.05, noteLen, new GrabularInstrument( vol, myFreqs[ 0 ], myTargetFreq ) );
  out.playNote( 0.10, noteLen, new GrabularInstrument( vol, myFreqs[ 1 ], myTargetFreq ) );
  out.playNote( 0.15, noteLen, new GrabularInstrument( vol, myFreqs[ 2 ], myTargetFreq ) );
  out.playNote( 0.20, noteLen, new GrabularInstrument( vol, myFreqs[ 3 ], myTargetFreq ) );
  out.playNote( 0.25, noteLen, new GrabularInstrument( vol, myFreqs[ 4 ], myTargetFreq ) );
  out.playNote( 0.30, noteLen, new GrabularInstrument( vol, myFreqs[ 5 ], myTargetFreq ) );
  out.playNote( 0.35, noteLen, new GrabularInstrument( vol, myFreqs[ 6 ], myTargetFreq ) );
  out.playNote( 0.40, noteLen, new GrabularInstrument( vol, myFreqs[ 7 ], myTargetFreq ) );
  out.playNote( 0.45, noteLen, new GrabularInstrument( vol, myFreqs[ 8 ], myTargetFreq ) );

 }

// draw is run many times
void draw()
{
  // erase the window to dark green
  background( 0, 64, 32 );
  // draw using a purple stroke
  stroke( 232, 0, 255 );
  // draw the waveforms
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
}

