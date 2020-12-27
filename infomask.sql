CREATE OR REPLACE FUNCTION decode_infomask(infomask int) RETURNS varchar AS $$ 
DECLARE 
result varchar;
BEGIN
        result := '';
        IF (infomask & x'0001'::int) = x'0001'::int THEN
            result := result || ' HEAP_HASNULL';
        END IF;
        
        IF (infomask & x'0002'::int) = x'0002'::int THEN
            result := result || ' HEAP_HASVARWIDTH';
        END IF;
        
        IF (infomask & x'0004'::int) = x'0004'::int THEN
            result := result || ' HEAP_HASEXTERNAL';
        END IF;
        
        IF (infomask & x'0008'::int) = x'0008'::int THEN
            result := result || ' HEAP_HASOID_OLD';
        END IF;

        IF (infomask & x'0020'::int) = x'0020'::int THEN
            result := result || ' HEAP_COMBOCID';
        END IF;
        
        IF (infomask & x'0080'::int) = x'0080'::int THEN
            result := result || ' HEAP_XMAX_LOCK_ONLY';
        END IF;
        
        IF (infomask & x'0040'::int = x'0040'::int) AND (infomask & x'0010'::int = x'0010'::int) THEN
            result := result || ' HEAP_XMAX_SHR_LOCK';            
        ELSIF (infomask & x'0040'::int) = x'0040'::int THEN
            result := result || ' HEAP_XMAX_EXCL_LOCK';
        ELSIF (infomask & x'0010'::int) = x'0010'::int THEN
            result :=  result || ' HEAP_XMAX_KEYSHR_LOCK';
        END IF;

        IF (infomask & x'0100'::int = x'0100'::int) AND (infomask & x'0200'::int = x'0200'::int) THEN
            result := result || ' HEAP_XMIN_FROZEN';            
        ELSIF (infomask & x'0100'::int) = x'0100'::int THEN
            result :=  result || ' HEAP_XMIN_COMMITTED';
        ELSIF (infomask & x'0200'::int) = x'0200'::int THEN
            result :=  result || ' HEAP_XMIN_INVALID';
        END IF;

        IF (infomask & x'0400'::int) = x'0400'::int THEN
            result :=  result || ' HEAP_XMAX_COMMITTED';
        END IF;

        IF (infomask & x'0800'::int) = x'0800'::int THEN
            result :=  result || ' HEAP_XMAX_INVALID';
        END IF;

        IF (infomask & x'1000'::int) = x'1000'::int THEN
            result :=  result || ' HEAP_XMAX_IS_MULTI';
        END IF;

        IF (infomask & x'2000'::int) = x'2000'::int THEN
            result :=  result || ' HEAP_UPDATED';
        END IF;

        IF (infomask & x'4000'::int = x'4000'::int) AND (infomask & x'8000'::int = x'8000'::int) THEN
            result := result || ' HEAP_MOVED';            
        ELSIF (infomask & x'4000'::int) = x'4000'::int THEN
            result :=  result || ' HEAP_MOVED_OFF';
        ELSIF (infomask & x'8000'::int) = x'8000'::int THEN
            result :=  result || ' HEAP_MOVED_IN';
        END IF;

        RETURN result;
END;
$$  LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION decode_infomask2(infomask int) RETURNS varchar AS $$ 
DECLARE 
result varchar;
BEGIN
        result := '';

        IF (infomask & x'2000'::int) = x'2000'::int THEN
            result := result || ' HEAP_KEYS_UPDATED';
        END IF;
        
        IF (infomask & x'4000'::int) = x'4000'::int THEN
            result :=  result || ' HEAP_HOT_UPDATED';
        END IF;

        IF (infomask & x'8000'::int) = x'8000'::int THEN
            result :=  result || ' HEAP_ONLY_TUPLE';
        END IF;

        RETURN result;
END;
$$  LANGUAGE plpgsql; 