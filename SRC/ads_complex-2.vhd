---- this file is part of the ADS library

library ads;
use ads.ads_fixed.all;

package ads_complex_pkg is
	-- complex number in rectangular form
	type ads_complex is
	record
		re: ads_sfixed;
		im: ads_sfixed;
	end record ads_complex;

	type stage_type is 
	record 
		z: ads_complex; 
		c: ads_complex; 
		stage_data: natural; 
		stage_overflow: boolean;
	end record stage_type;
	
	type StageTypeVector is array (natural range <>) of stage_type;
	
	---- functions

	-- make a complex number
	function ads_cmplx (
			re, im: in ads_sfixed
		) return ads_complex;

	-- returns l + r
	function "+" (
			l, r: in ads_complex
		) return ads_complex;

	-- returns l - r
	function "-" (
			l, r: in ads_complex
		) return ads_complex;

	-- returns l * r
	function "*" (
			l, r: in ads_complex
		) return ads_complex;

	-- returns the complex conjugate of arg
	function conj (
			arg: in ads_complex
		) return ads_complex;

	-- returns || arg || ** 2
	function abs2 (
			arg: in ads_complex
		) return ads_sfixed;

	-- constants
	constant complex_zero: ads_complex :=
					ads_cmplx(to_ads_sfixed(0), to_ads_sfixed(0));

end package ads_complex_pkg;

package body ads_complex_pkg is

	-- function implementations
	function "+" (
			l, r: in ads_complex
		) return ads_complex
	is
		variable ret: ads_complex;
	begin
		ret.re := l.re + r.re;
		ret.im := l.im + r.im;
		return ret;
	end function "+";

	-- implement all other functions here
	function "-" (
			l, r: in ads_complex
		) return ads_complex
	is
		variable ret: ads_complex;
	begin
		ret.re := l.re - r.re;
		ret.im := l.im - r.im;
		return ret;
	end function "-";
	
	--function to create a complex number
	function ads_cmplx (
		re, im: in ads_sfixed
		) return ads_complex
	is 
		variable ret: ads_complex;
	begin
		ret.re := re;
		ret.im := im;
		return ret;
	end function ads_cmplx;
	
	--function abs2
	function abs2 (
			arg: in ads_complex
		) return ads_sfixed
	is
		variable ret: ads_sfixed;
	begin
		ret := (arg.re * arg.re + arg.im * arg.im);
		return ret;
	end function abs2;
	
	--function "*"
	function "*" (
			l, r: in ads_complex
		) return ads_complex
	is
		variable ret: ads_complex;
	begin
		ret.re := (l.re * r.re) - (l.im * r.im);
		ret.im := (l.re * r.im) + (l.im * r.re);
		return ret;
	end function "*";
	
	--function conj
	function conj (
			arg: in ads_complex
		) return ads_complex
	is
		variable ret: ads_complex;
	begin
		ret.re := arg.re;
		ret.im := -arg.im;
		return ret;
	end function conj;
	
	--function ads_square
	function ads_square (
			arg: in ads_complex
		) return ads_complex
	is
		variable ret: ads_complex;
	begin
		ret := arg * arg;
		return ret;
	end function ads_square;

end package body ads_complex_pkg;
