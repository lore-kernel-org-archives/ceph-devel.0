From: Bharath Krishna <BKrishna@walmartlabs.com>
Subject: Re: Teuthology Integration to native openstack
Date: Mon, 28 Sep 2015 05:24:58 +0000
Message-ID: <D22ECA7E.15C3%bkrishna@walmartlabs.com>
References: <D22E3F64.15AF%bkrishna@walmartlabs.com>
 <56084EDE.9050005@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppes-mail-n1.wal-mart.com ([161.168.202.15]:36967 "EHLO
	PPES-Mail-N1.wal-mart.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbI1FfG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 01:35:06 -0400
In-Reply-To: <56084EDE.9050005@dachary.org>
Content-Language: en-US
Content-ID: <D5BD50C8A25B0F4ABB79D5325D0CC04C@email.wal-mart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Dachary,

Thanks for the reply. I am following your blog http://dachary.org/?p=3D=
3767
And the README in=20
https://github.com/dachary/teuthology/tree/wip-6502-openstack-v2/#opens=
tack
-backend

I have sourced the openrc file of my Openstack deployment and verified
that clients are working fine. My Openstack deployment has Cinder
integrated with CEPH backend.

I have cloned and installed teuthology using the below steps:

$ git clone -b wip-6502-openstack-v2 http://github.com/dachary/teutholo=
gy
$ cd teuthology ; ./bootstrap install
$ source virtualenv/bin/activate


Then I tried to run a dummy suite as test and I ran into following erro=
r:

Traceback (most recent call last):
  File "/root/teuthology/virtualenv/bin/teuthology-openstack", line 9, =
in
<module>
    load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
'teuthology-openstack')()
  File "/root/teuthology/scripts/openstack.py", line 8, in main
    teuthology.openstack.main(parse_args(argv), argv)
  File "/root/teuthology/teuthology/openstack.py", line 375, in main
    return TeuthologyOpenStack(ctx, teuth_config, argv).main()
  File "/root/teuthology/teuthology/openstack.py", line 181, in main
    self.verify_openstack()
  File "/root/teuthology/teuthology/openstack.py", line 270, in
verify_openstack
    str(providers))
Exception: ('OS_AUTH_URL=3Dhttp://<ip-address>:5000/v2.0', " does is no=
t a
known OpenStack provider (('cloud.ovh.net', 'ovh'), ('control.os1.phx2'=
,
'redhat'), ('entercloudsuite.com', 'entercloudsuite'))")


Thank you.

Regards,
M Bharath Krishna

On 9/28/15, 1:47 AM, "Loic Dachary" <loic@dachary.org> wrote:

>[moving to ceph-devel]
>
>Hi,
>
>On 27/09/2015 21:20, Bharath Krishna wrote:
>> Hi,
>>=20
>> We have an openstack deployment in place with CEPH as CINDER backend=
=2E
>>=20
>> We would like to perform functional testing for CEPH and found
>>teuthology as recommended option.
>>=20
>> Have successfully installed teuthology. Now to integrate it with
>>Openstack, I could see that the possible providers could be either OV=
H,
>>REDHAT or ENTERCLOUDSITE.
>>=20
>> Is there any option where in we can source openstack deployment of o=
ur
>>own and test CEPH using teuthology?
>
>The documentation mentions these providers because they have been test=
ed.
>But there should be no blocker to run teuthology against a regular
>OpenStack provider. Should you run into troubles, please let me know a=
nd
>I'll help.
>
>Cheers
>
>>=20
>> If NO, please suggest on how to test CEPH in such scenarios?
>>=20
>> Please help.
>>=20
>> Thank you.
>> Bharath Krishna
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>
>--=20
>Lo=EFc Dachary, Artisan Logiciel Libre
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
