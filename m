From: Dan Mick <dmick@redhat.com>
Subject: Re: =?UTF-8?B?562U5aSNOiBoZWxsbywgSSBhbSBjb25mdXNlZCBhYm91dCBhIHE=?=
 =?UTF-8?B?dWVzdGlvbiBvZiByYmQ=?=
Date: Thu, 23 Jul 2015 18:21:05 -0700
Message-ID: <55B19301.5020806@redhat.com>
References: <7B5C2F2226F8AF419D625C6097AD814C5E265628@H3CMLB12-EX.srv.huawei-3com.com> <1804564100.2788995.1437656606063.JavaMail.zimbra@redhat.com> <55B15B9B.2020103@redhat.com> <7B5C2F2226F8AF419D625C6097AD814C5E2656E2@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbGXBVH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 21:21:07 -0400
In-Reply-To: <7B5C2F2226F8AF419D625C6097AD814C5E2656E2@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "zhengbin.08747@h3c.com" <zhengbin.08747@h3c.com>, ceph-devel <ceph-devel@vger.kernel.org>

Adding back ceph-devel

My point was, ok, ruling out 0, then we can create a block device of
size 1 byte.  Is that useful?  No, it is not.  How about 10 bytes?
1000?  1MB?

There's no good reason to rule out zero.  Is it causing a problem someh=
ow?

On 07/23/2015 06:06 PM, zhengbin.08747@h3c.com wrote:
> If I create a block whose size is zero, it means you absolutely can n=
ot use it unless you resize it
>=20
>=20
> what arbitrary minimum size is too small?  -----> I do not know, If I=
 create a block whose size is larger than zero,it may be can use.
> And why do we have to define a minimum size? we can just make sure th=
e block size is larger than zero
>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Dan Mick [mailto:dmick@redhat.com]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B47=E6=9C=8824=E6=97=
=A5 5:25
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Jason Dillaman; zhengbin 08747 (RD)
> =E6=8A=84=E9=80=81: ceph-devel
> =E4=B8=BB=E9=A2=98: Re: hello, I am confused about a question of rbd
>=20
> Why not zero?
>=20
> If the answer is "it can't be used", then, what arbitrary minimum siz=
e is too small?
>=20
> (also, given that resize exists, it can be used for storage after a r=
esize.)
>=20
> On 07/23/2015 06:03 AM, Jason Dillaman wrote:
>> According to the git history, support for zero MB images for the cre=
ate/resize commands was explicitly added by commit 08f47a4.  Dan Mick o=
r Josh Durgin could probably better explain the history behind the chan=
ge since it was before my time.
>>
>=20
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from=
 H3C, which is
> intended only for the person or entity whose address is listed above.=
 Any use of the
> information contained herein in any way (including, but not limited t=
o, total or partial
> disclosure, reproduction, or dissemination) by persons other than the=
 intended
> recipient(s) is prohibited. If you receive this e-mail in error, plea=
se notify the sender
> by phone or email immediately and delete it!
>=20

--=20
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
