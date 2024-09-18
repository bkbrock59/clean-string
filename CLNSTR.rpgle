**free

     ctl-opt DeBug(*yes) DatEdit(*YMD)
             Option(*NoDebugIO: *SrcStmt)
             FixNbr(*Zoned: *InputPacked)
             AlwNull(*UsrCtl)
             DftActGrp(*No);

     dcl-s  dirtyString                char(75);
     dcl-s  cleanString                char(75);

// Main ---------------------------------------------------------------------------------------
     exec sql
        set option
            commit    = *none,
            closqlcsr = *endmod,
            datfmt    = *iso;

     dirtyString = 'Hello, I am a string ' + x'000525' + 'with uninvited chars.';
     cleanString = CleanUp(dirtyString : 1);
     cleanString = CleanUp(dirtyString);

     EndPgm();
     
// CleanUp ------------------------------------------------------------------------------------
     dcl-proc CleanUp;

        dcl-pi *n                   varchar(32767);
           input                    varchar(32767) const;
           exceptions                   int(5)     const   options(*nopass);
        end-pi;

        dcl-c  C_VALID_CHARS          const(x'404A4B4C4D4E4F505A5B5C5D5E5F60616A6B6C6D6E6F797A7B7C7D7E7F818283848586878889919293949596979899A1+
                                              A2A3A4A5A6A7A8A9C0C1C2C3C4C5C6C7C8C9D0D1D2D3D4D5D6D7D8D9E0E2E3E4E5E6E7E8E9F0F1F2F3F4F5F6F7F8F9');

        dcl-c  C_EXCEPTIONS_1         const(x'0525');       // Line feed and horizontal tab

        dcl-s  char                    char(1);
        dcl-s  allowedChars         varchar(1000);
        dcl-s  output               varchar(32767);
        dcl-s  i                        int(10);

        allowedChars = C_VALID_CHARS;

        if %parms = %parmnum(exceptions);
           select;
              when exceptions = 1;
                 allowedChars = C_VALID_CHARS + C_EXCEPTIONS_1;
           endsl;
        endif;

        for i = 1 to %len(%trim(input));
           char = %subst(input : i : 1);
           if %scan(char : allowedChars) > 0;
              output += char;
           endif;
        endfor;

        return output;

     end-proc CleanUp;

// EndPgm -------------------------------------------------------------------------------------
     dcl-proc EndPgm;

        *inlr = *on;
        return;

     end-proc EndPgm; 
