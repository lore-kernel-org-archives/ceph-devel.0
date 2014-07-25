From: Adam Crume <adamcrume@gmail.com>
Subject: Re: LTTng unfriendly with mixed static/dynamic linking
Date: Fri, 25 Jul 2014 14:22:37 -0700
Message-ID: <CAFu9Dv3FY=RkC9cAqt8p5oB0FNHsLUnK=1Nx3eh==C8Q4-i1Ww@mail.gmail.com>
References: <CAFu9Dv37reLPuQ_9fHkgqwDWtKiwQk8FCd4MAqY6wk75ASs07w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b5d484036bd3b04ff0b2c62
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52588 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaGYVWj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 17:22:39 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so6214699oac.22
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 14:22:38 -0700 (PDT)
In-Reply-To: <CAFu9Dv37reLPuQ_9fHkgqwDWtKiwQk8FCd4MAqY6wk75ASs07w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--047d7b5d484036bd3b04ff0b2c62
Content-Type: text/plain; charset=ISO-8859-1

I tried all solutions, and it looks like only #1 works.  #2 gives the
error "/usr/bin/ld: main: hidden symbol `tracepoint_dlopen' in
common_tp.a(common_tp.o) is referenced by DSO" when linking.  #3 gives
the error "./liblibrary.so: undefined reference to
`tracepoint_dlopen'" when linking.  (Linking is complicated by the
fact that LTTng uses special symbol attributes, and tracepoint_dlopen
happens to be weak and hidden.)  Unless I'm mistaken (and I very well
may be), we will have to ensure that all traced code is either 1)
placed in a shared library and never statically linked elsewhere, or
2) never linked into any shared library.

Thoughts?

Adam

On Fri, Jul 25, 2014 at 11:48 AM, Adam Crume <adamcrume@gmail.com> wrote:
> LTTng requires tracepoints to be linked into a program only once.  If
> tracepoints are linked in multiple times, the program crashes at
> startup with: "LTTng-UST: Error (-17) while registering tracepoint
> probe. Duplicate registration of tracepoint probes having the same
> name is not allowed."
>
> This is problematic when mixing static and dynamic linking.  If the
> tracepoints are in a static library, that library can end up in an
> executable multiple times by being linked in directly, as well as
> being statically linked into a dynamic library.  Even if the
> tracepoints are not linked directly into the executable, they can be
> statically linked into multiple dynamic libraries that the executable
> loads.
>
> For us, this problem shows up with libcommon, and could show up with
> others such as libosd.  (In general, I think anything added to
> noinst_LTLIBRARIES is static, and anything added to lib_LTLIBRARIES is
> dynamic.)
>
> There are a few ways of solving the issue:
> 1. Change every library that has tracepoints, like libcommon, from
> static to dynamic.  This could be a big change, as at the very least
> we'd have to rename the library to something like libceph_common to
> avoid conflicts, since now it would be an installed file.  This has
> the advantage of keeping code and its tracepoints in the same library.
> 2. Keep tracepoints in a separate static library.  For example,
> libcommon and libcommon_tp.  Unfortunately, every executable (but not
> library!) that links in libcommon (directly or indirectly) would have
> to manually link in libcommon_tp, and I don't think Automake could
> automate that.
> 3. Keep tracepoints in a separate dynamic library.  In this case, I
> think libcommon could depend on libcommon_tp, so executables would not
> have to manually link in libcommon_tp.  (I'm not an Automake expert,
> so let me know if I'm wrong on that.)  Again, libcommon_tp would be an
> installed file, so we'd want to rename it to something like
> libceph_common_tp.
>
> I attached a minimal test case of the problem.
>
> Thoughts or suggestions?
>
> Thanks,
> Adam Crume

--047d7b5d484036bd3b04ff0b2c62
Content-Type: application/x-gzip;
	name="lttng-duplicate-tracepoints-sol1.tar.gz"
Content-Disposition: attachment;
	filename="lttng-duplicate-tracepoints-sol1.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hy208i561

H4sIAM/F0lMAA+2a72+aQBjHfev9FTfbJrYRBERMXLfEqmvNrDXObGmyhFDESsYPA7hkWfa/7wDB
A7TY2tE1fT4vysHdPc/B8X147qzhedY9M1stDV1VPI3xHEXVlrZueS7j2gZfLx0OR2i1muQoNERB
oI4xJV5oSGJTFFotvsQJHNeUSrj5DL5zWbme4mBcUmaKqTorU9vRLq/+lWLkzb+h3zmK84tdPN2H
P8GSJO6ef4GP5p+XGg0y/7wkcSXMPd9t7uaNz/9PW59hMsfyfGWp1dP36KUHBBRKrv5V2zRt6xD5
76F/Ma3/JtcC/RdBoP9wjiEEvEH21b96gI88/QsCl9U/fP8L4Ui3VGM103AlCvQVlL4me0v/MsrG
CvwbYcLmpamG1TW6GYkofqOlQ+rn1cqVZhg2nju2STf6blVIuz8Qewpm7/z/gACQp3+S7Wfz/ybo
vwg2Wo8XetkAsFH/ZqWwln4qddgh9KgbqPx/I1f/18oPba4bh7z2Ofonyhfi/R+u0Qq+/7wI+i8C
xTDa2FR0C6ETVsUn7KJN/nhLVA7fjHvNYrwlPj7HjI2Pz0iT8LhAyO/F2mFvVkVlldT1ppNOtz++
GYym8nhyc9GXe7ejzvWgKw8Ho8+dyz5mBixmAith/6g7WocaYjBKOTGVfoTm5+NB93FOIqux0ciR
bzX25Z88o7vANm0aIRIB1yNwbZZnuXZ6ZEEfVL73/boLxdFmmPlm1IgILcXUasn+vqu0xe0GU47b
mW5koi3icZ61l7yQtJS2s8NK4jSwEHxiwu5hWvHUJx3bokz5DqKz6DEn2m0qH3zStI21r6RZyioz
JCMywpvMDKCd7Uo/qaxR+krKWsbWLkupGw102o7URk9I+omosSyj1vTNkcK6sV8KggOJnaQ8M4im
DE2x2qjsmGQuw3hClWXqq+Jra0eNGtUkhJi+FLc6Y5VN0d4U3USZPUPs+OpmdEsU5w8Sco8Ee67/
/QfvLZ/oIzf/51qp/F8QeVj/FwIVcftf+6PptgV8LUjrp2O5M7n8Uj2NTz8N+sMeuYBOQVSvlVz9
OyvrUB+5v/+K6fU/J3GQ/xfC0bv6nW7V7xSXZPTDHkm0Liadya087kyvPrCYrQff8pceJfCvyNV/
uDw7yEfu95/EhtT+Hy/C/l8hxFt9564302128XHr7t/WbUJE3pIgi39oN5D+3wL/3NG8lWNhDrYB
AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAODR/AULQBUzAFAAAA==
--047d7b5d484036bd3b04ff0b2c62
Content-Type: application/x-gzip;
	name="lttng-duplicate-tracepoints-sol2.tar.gz"
Content-Disposition: attachment;
	filename="lttng-duplicate-tracepoints-sol2.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hy208i5z2

H4sIANTF0lMAA+2abW+aUBTHfev9FHe2TWwjCIiYuG6Jra41s9Y4s6XJEkIRKxkPDrDJsuy77wCC
iDps7Wibnt+LAveeew70nv99ag3Ps+6Y8Xxm6KriaYznKKo2s3XLcxnXNoRqYX84oNGow1WoiYKQ
uMYUeKEmiXVRaEh8gRM4ri4VaP0JYmcydz3FobSgjBVTdeamtsUuq/6VYmT1v6HfOorzi50+Pobf
wZIkbu9/gY/7nxc46H9eqvMFyj3dZ27njff/va2PKfSxPJlbavn4PXnuF0JyJVP/qm2atrWP/HfQ
v5jWfx2mBNR/DgT6D/sYh4A3yK76V/eIkaV/QeDS+hcbOP/nwoFuqcZ8rNFSNNCXSLpM9mZ+MVkf
K+hvQoFl0pTD6krSDEYU32jmQP2kXLrUDMOmE8c2k0bfrRLY/cGxJ2d2Xv/vMQBk6Z+XpPX1v4T6
z4Ol1uON3voAsFT/cqewkH5q6bBF6FEzVPlLI1P/V8oPbaIb+6R9hv5hthdi/de4RrD+53H+zwXF
MJrUVHSLkCNWpUfstAk/vBkphplxp1mMN6OHp5Sx6eEJmITXKSF+K9YOW7MqKapQ1x4NW+edwXW3
P5IHw+uzjty+6beuuudyr9v/3LroUKbLUibwEraPmpPFUAMOoyUnTSw/QveTQff8YUEir7HTKJDv
NY7lPzxhuMB30nX8dUr8dTYpQt4x6v3PqERZViXeUUm+41qjwGLFgETjOHxcPHc/9nNiXwlXfoDo
ybVZnuWaCbvoW0jxzg/pThVHG1Pmm1GB4cRSTK2Sar4Is+pxk8N03OZ6M0haC2JONjtMlqS8rfna
5mn1OdRAM8rkuB9XjJI9FfZDmPNRK6YHv21jYZ/OhbB/oToQI4xVcD82ID8MTbGapOiY0K2hfhP3
cmIU93N5S40a1awkfrootjrx3z+6tZe37so9e0LYweV1/wby1n9JnOtfNDvu//1E8GaPjJG5/oc5
f3X9L4gczv+5kJgMOl87/dGmDXwlWNaPBnJrePGlfBw/fup2em0oIMco8tdKpv6dubVvjMy//4rp
/T9XB3PUfw4cvKve6lb1VnFhRd9rwxrwbNga3siD1ujyA0vZarC2eO63RP4XmfoPt2d7xcic/0Hs
qfM/vobnf7kQH/Wdut5Yt9npx42nfxuPCQlkSbCr+NdpYPJ/C/xnR/PmjkU5PAZEEARBEARBEARB
EARBEARBEARBEARBEARBEARBEARBkAfzF0g8uckAUAAA
--047d7b5d484036bd3b04ff0b2c62
Content-Type: application/x-gzip;
	name="lttng-duplicate-tracepoints-sol3.tar.gz"
Content-Disposition: attachment;
	filename="lttng-duplicate-tracepoints-sol3.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hy208i6j3

H4sIANvF0lMAA+2abW+aUBTHfev9FHe2TWwjCAiauG6Jra41s9Y4s6XJEkMRKxmCA2yyLPvuO4A8
CFps7eiant8LhftwDuXwP5x7re44xh0zWS50TZEdlXEsWVEXpmY4NmObeq1a2B8OaDQk+BZqoiDE
vkMKvFCri5IoNCSuwAkcJ0kFKj2D70yWtiNblBbkiTxXrOVc3TIuq/+VomfFX9duLdn6xc6e7sMN
cL0ubo+/wAfx5/l6HeIPn7UC5Z7vz9zOG4//valNKMR4PF0aSvn4PXnpC0JyJVP/ijmfm8Y+8t9B
/2JS/xIvoP7zwNO/H2NMAW+QXfWv7OEjS/+CwKX0z+H7PxcONEPRlxOVloJEXyLJtrGzcJtJOlfQ
34QC0UNT9rsr8WGQUdxBCwv6p+XSparrJp1a5jw+6LtRgnF/MPfkzM71/x4JIEv/ruaT9X+DQ/3n
QaT1cKGXTgCR+qOVwkr6idJhi9CDaajy/41M/V/JP9Sppu/z2GfoXxAbjXD/RxJF7/1fQ/3ngqzr
TTqXNYOQI1ahR+ysCR/OghT9J+NONRhnQQ9PKWPSwxMY4n/PCHFnsaY/m1VIUYG+9mjYOu8Mrrv9
0XgwvD7rjNs3/dZV93zc6/Y/ty46lOmylPGs+POD6WSVasBgUHLSWPnhm58OuuePcxJYDY0Gjlyr
oS/35BndebbjpgmBDBid2ybLs1zcuUmKd65HeyZb6oQy3/QKyM+Q52olNdP1s8HcmrW0v+amORBl
A5xON9pLtaWsbrC53WKyJYy4HEYc7gJokVHufwYtctRFgheU79YvSp4ap9BWzJTrIDgLIhSNCy7o
wUDFp6/crFvcZDDpt5meFr+raYPxloS1lK1tltbPfXE3A4mGwVgblAqoFwtf0MFMpgd3XF/NgaNw
fGQTur1MA4kYjic6PBe6KhtNUrTmEFo/OcWOx7FXlCvULT1K0LOm6mRTOOrEjWxwaEaH9toxe0LY
weV1/wYeWfciX38hs+P6371XzuKJPjLrf66RqP8Fkcf1fy7Ecmbna6c/2rSAr3hl/Wgwbg0vvpSP
w9NP3U6vDQ3k+PXr4K2SqX9raezrI/P3XzG5/ufqkBJQ/zlw8K56qxnVW9mGir7XhlLpbNga3owH
rdHlB5ayVe/1+9JXifwrMvXvL8/28pH5/ofckNj/4yVc/+dCuNV3ajsTzWRnHzfu/m3cJiTwlHiF
90O7gfH/LXDPLdVZWgblcBsQQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQR7NXy6oP9wA
UAAA
--047d7b5d484036bd3b04ff0b2c62--
