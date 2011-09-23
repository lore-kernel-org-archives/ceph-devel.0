From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: [PATCH] crushtool: fix args parsing
Date: Fri, 23 Sep 2011 11:21:18 +0800
Message-ID: <CANExM-OrCz8S5R6XAkwERoNDcqBVPc6VU_OhyJ1hqjq8_eFhdg@mail.gmail.com>
References: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
	<Pine.LNX.4.64.1109220943590.17520@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba6e900478c33b04ad934daa
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65387 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1IWDVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 23:21:19 -0400
Received: by iaqq3 with SMTP id q3so3442017iaq.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 20:21:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109220943590.17520@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

--90e6ba6e900478c33b04ad934daa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

In fact, I got two problems with the crushtool after upgrading from
0.34 to 0.35.

1. crushtool failed to parse args.

I have a template crushmap (as attached) which only consists of the
root. For each disk, I will use the crushtool to add it to the
crushmap. The command series look like:

$ crushtool -i /etc/ceph/crush.template --add-item 0 1.0 device0 --loc
host host0 --loc cluster cluster0 -o /tmp/crush0
$ crushtool -i /tmp/crush0 --add-item 1 1.0 device1 --loc host host0
--loc cluster cluster0 -o /tmp/crush1


2. crushtool rejected the command due to the commit 58f98e7.

I inverted the commit when upgrading to v0.35.

Henry

2011/9/23 Sage Weil <sage@newdream.net>:
> Hey Henry-
>
> Do you have a list of commands that were failing handy? =C2=A0I'd like to
> extend the cli unit tests at the same time (src/test/cli/crushtool).
>
> Thanks-
> sage
>
>
> On Fri, 23 Sep 2011, Henry C Chang wrote:
>
>> Fix --add-item and --loc args parsing.
>>
>> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
>> ---
>> =C2=A0src/crushtool.cc | =C2=A0 13 +------------
>> =C2=A01 files changed, 1 insertions(+), 12 deletions(-)
>>
>> diff --git a/src/crushtool.cc b/src/crushtool.cc
>> index 51531aa..f0ccb9b 100644
>> --- a/src/crushtool.cc
>> +++ b/src/crushtool.cc
>> @@ -872,9 +872,6 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> =C2=A0 =C2=A0 =C2=A0 usage();
>> - =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> - =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> - =C2=A0 =C2=A0 usage();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0add_weight =3D atof(*i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> @@ -885,9 +882,6 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0std::string type(val);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> =C2=A0 =C2=A0 =C2=A0 usage();
>> - =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> - =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> - =C2=A0 =C2=A0 usage();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0std::string name(*i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0add_loc[type] =3D name;
>> @@ -897,9 +891,6 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0reweight_name =3D val;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> =C2=A0 =C2=A0 =C2=A0 usage();
>> - =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> - =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> - =C2=A0 =C2=A0 usage();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0reweight_weight =3D atof(*i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> =C2=A0 =C2=A0 =C2=A0} else if (ceph_argparse_flag(args, i, "--build", (c=
har*)NULL)) {
>> @@ -954,10 +945,8 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int dev =3D tmp;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> =C2=A0 =C2=A0 =C2=A0 usage();
>> - =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> - =C2=A0 =C2=A0 =C2=A0if (i =3D=3D args.end())
>> - =C2=A0 =C2=A0 usage();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0float f =3D atof(*i);
>> + =C2=A0 =C2=A0 =C2=A0i =3D args.erase(i);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int w =3D (int)(f * 0x10000);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (w < 0)
>> =C2=A0 =C2=A0 =C2=A0 w =3D 0;
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>>
>>
>

--90e6ba6e900478c33b04ad934daa
Content-Type: application/octet-stream; name="crush.template"
Content-Disposition: attachment; filename="crush.template"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gswlolkx0

AAABAAgAAAADAAAAAAAAAAQAAAD/////AgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAEAAAADAAAAAAEBCgEAAAD/////AAAAAAYAAAAAAAAAAQAAAAQAAAAAAAAAAAAAAAEA
AAADAAAAAQEBCgEAAAD/////AAAAAAYAAAAAAAAAAQAAAAQAAAAAAAAAAAAAAAEAAAADAAAAAgEB
CgEAAAD/////AAAAAAYAAAAAAAAAAQAAAAQAAAAAAAAAAAAAAAMAAAAAAAAABgAAAGRldmljZQEA
AAAEAAAAaG9zdAIAAAAHAAAAY2x1c3RlcgEAAAD/////CAAAAGNsdXN0ZXIwAwAAAAAAAAAEAAAA
ZGF0YQEAAAAIAAAAbWV0YWRhdGECAAAAAwAAAHJiZA==
--90e6ba6e900478c33b04ad934daa--
