From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: [PATCH] Statically binding ports for ceph-osd
Date: Tue, 10 Apr 2012 12:56:53 -0700
Message-ID: <CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com>
References: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3040e4d038d93604bd58863e
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49292 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890Ab2DJT4y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 15:56:54 -0400
Received: by ghrr11 with SMTP id r11so130061ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 12:56:53 -0700 (PDT)
In-Reply-To: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--20cf3040e4d038d93604bd58863e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

After doing some more looking at the code, it appears that this option
is not supported.  I created a small patch (attached) which adds the
functionality.  Is there any way we could get this, or something like
this, applied upstream?  I think this is important functionality for
firewalled environments, and seems like a simple fix since all the
other services (including ones for ceph-mon and ceph-mds) already
allow you to specify a static port.


On Mon, Apr 9, 2012 at 5:27 PM, Nick Bartos <nick@pistoncloud.com> wrote:
> I'm trying to get ceph-osd's listening ports to be set statically for
> firewall reasons. =A0I am able to get 2 of the 3 ports set statically,
> however the 3rd one is still getting set dynamically.
>
> I am using:
>
> [osd.48]
> =A0 =A0host =3D 172.16.0.13
> =A0 =A0cluster addr =3D 172.16.0.13:6944
> =A0 =A0public addr =3D 172.16.0.13:6945
>
> The daemon will successfully bind to 6944 and 6945, but also binds to
> 6800. =A0What additional option do I need? =A0I started looking at the
> code and thought "hb addr =3D 172.16.0.13:6946" would do it, but
> specifying that option seems to have no effect (or at least does not
> achieve the desired result).

--20cf3040e4d038d93604bd58863e
Content-Type: application/octet-stream; name="ceph-0.41-osd_hb_port.patch"
Content-Disposition: attachment; filename="ceph-0.41-osd_hb_port.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0vd9zje0

ZGlmZiAtVTMgLXIgY2VwaC0wLjQxLm9yaWcvc3JjL2NlcGhfb3NkLmNjIGNlcGgtMC40MS9zcmMv
Y2VwaF9vc2QuY2MKLS0tIGNlcGgtMC40MS5vcmlnL3NyYy9jZXBoX29zZC5jYwkyMDEyLTAxLTI3
IDEyOjM1OjM5LjAwMDAwMDAwMCAtMDgwMAorKysgY2VwaC0wLjQxL3NyYy9jZXBoX29zZC5jYwky
MDEyLTA0LTEwIDA5OjU3OjA4LjYwMDgxNzk1NCAtMDcwMApAQCAtMzA3LDcgKzMwNywxMSBAQAog
ICAvLyBoYiBzaG91bGQgYmluZCB0byBzYW1lIGlwIGFzIGNsdXN0ZXJfYWRkciAoaWYgc3BlY2lm
aWVkKQogICBlbnRpdHlfYWRkcl90IGhiX2FkZHIgPSBnX2NvbmYtPmNsdXN0ZXJfYWRkcjsKICAg
aWYgKCFoYl9hZGRyLmlzX2JsYW5rX2lwKCkpCi0gICAgaGJfYWRkci5zZXRfcG9ydCgwKTsKKyAg
ICAvLyBPbmx5IHVzZSBvc2RfaGJfcG9ydCBpZiBpdCdzIGEgdmFsaWQgcG9ydC4KKyAgICBpZiAo
Z19jb25mLT5vc2RfaGJfcG9ydCA+IDAgJiYgZ19jb25mLT5vc2RfaGJfcG9ydCA8IDY1NTM2KQor
ICAgICAgICBoYl9hZGRyLnNldF9wb3J0KGdfY29uZi0+b3NkX2hiX3BvcnQpOworICAgIGVsc2UK
KyAgICAgICAgaGJfYWRkci5zZXRfcG9ydCgwKTsKICAgciA9IG1lc3Nlbmdlcl9oYm91dC0+Ymlu
ZChoYl9hZGRyLCBnZXRwaWQoKSk7CiAgIGlmIChyIDwgMCkKICAgICBleGl0KDEpOwpkaWZmIC1V
MyAtciBjZXBoLTAuNDEub3JpZy9zcmMvY29tbW9uL2NvbmZpZ19vcHRzLmggY2VwaC0wLjQxL3Ny
Yy9jb21tb24vY29uZmlnX29wdHMuaAotLS0gY2VwaC0wLjQxLm9yaWcvc3JjL2NvbW1vbi9jb25m
aWdfb3B0cy5oCTIwMTItMDEtMjMgMTA6MjQ6MzUuMDAwMDAwMDAwIC0wODAwCisrKyBjZXBoLTAu
NDEvc3JjL2NvbW1vbi9jb25maWdfb3B0cy5oCTIwMTItMDQtMTAgMDk6NDY6NDIuNDA5NDI4ODEx
IC0wNzAwCkBAIC0yOTUsNiArMjk1LDcgQEAKIE9QVElPTihvc2RfbWF4X25vdGlmeV90aW1lb3V0
LCBPUFRfVTMyLCAzMCkgLy8gbWF4IG5vdGlmeSB0aW1lb3V0IGluIHNlY29uZHMKIE9QVElPTihv
c2Rfa2lsbF9iYWNrZmlsbF9hdCwgT1BUX0lOVCwgMCkKIE9QVElPTihvc2RfbWluX3BnX2xvZ19l
bnRyaWVzLCBPUFRfVTMyLCAxMDAwKSAvLyBudW1iZXIgb2YgZW50cmllcyB0byBrZWVwIGluIHRo
ZSBwZyBsb2cgd2hlbiB0cmltbWluZyBpdAorT1BUSU9OKG9zZF9oYl9wb3J0LCBPUFRfSU5ULCAw
KQogT1BUSU9OKGZpbGVzdG9yZSwgT1BUX0JPT0wsIGZhbHNlKQogT1BUSU9OKGZpbGVzdG9yZV9t
YXhfc3luY19pbnRlcnZhbCwgT1BUX0RPVUJMRSwgNSkgICAgLy8gc2Vjb25kcwogT1BUSU9OKGZp
bGVzdG9yZV9taW5fc3luY19pbnRlcnZhbCwgT1BUX0RPVUJMRSwgLjAxKSAgLy8gc2Vjb25kcwo=
--20cf3040e4d038d93604bd58863e--
