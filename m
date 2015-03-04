From: Butkeev Stas <staerist@ya.ru>
Subject: Re: Problems with "shadow" objects
Date: Wed, 04 Mar 2015 15:40:00 +0300
Message-ID: <607081425472800@web2m.yandex.ru>
References: <1809941425380648@web25h.yandex.ru> <54F6D4BB.1030209@orange.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from forward2m.mail.yandex.net ([37.140.138.2]:33500 "EHLO
	forward2m.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984AbbCDMrb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 07:47:31 -0500
In-Reply-To: <54F6D4BB.1030209@orange.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexis KOALLA <alexis.koalla@orange.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello, Alex
I have some questions on you answer
> If you want to remove these chunks =C2=A0you just =C2=A0need to remov=
e the parent object to which they are linked.
How can I determine parent object?

>> =C2=A02) What does the name of this "shadow" files?
>> =C2=A0example
>> =C2=A0with normal object:
>> =C2=A0# radosgw-admin object stat --bucket=3Ddev --object=3D"RegExp_=
tutorial.png"
>> =C2=A0and I receive information about this object.
>>
>> =C2=A0with "shadow" object:
>> =C2=A0default.4507.1_ - bucket-id
>> =C2=A0radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_t=
est_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
>> =C2=A0ERROR: failed to stat object, returned error: (2) No such file=
 or directory
>> =C2=A0how can I determine name of this object
>
> In the command above you forgot to type the full object name
> "default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.3_5=
 "
> Your command should looks like this:
> * #**rdosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_test=
_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
> *

What does different between my command and your command?
my command
radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_test_s3.2/=
2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
your command
radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_test_s3.2/=
2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"

they are the same

If I try use full object name, I receive error
Exemple

[root@rgw-node-2 ~]# radosgw-admin object stat --bucket=3Dtest1111 --ob=
ject=3D"current_structure_Compressor.jpg"              =20
{ "name": "current_structure_Compressor.jpg",
  "size": 51249,
  "policy": { "acl": { "acl_user_map": [
                { "user": "admin",
                  "acl": 15}],
          "acl_group_map": [],
=2E.....

[root@rgw-node-2 ~]# radosgw-admin object stat --bucket=3Dtest1111 --ob=
ject=3D"default.4380.1_current_structure_Compressor.jpg"
ERROR: failed to stat object, returned error: (2) No such file or direc=
tory


--=C2=A0
Best Regards,
Stanislav Butkeev


04.03.2015, 12:47, "Alexis KOALLA" <alexis.koalla@orange.com>:
> Hi Stas,
> My comments below in the mail
>
> Le 03/03/2015 12:04, Butkeev Stas a =C3=A9crit :
>> =C2=A0Hello, all
>>
>> =C2=A0I have ceph+RGW installation. And have some problems with "sha=
dow" objects.
>>
>> =C2=A0For example:
>> =C2=A0#rados ls -p .rgw.buckets|grep "default.4507.1"
>>
>> =C2=A0.....
>> =C2=A0default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY7=
6U.1_5
>> =C2=A0default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY7=
6U.2_2
>> =C2=A0default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY7=
6U.6_4
>> =C2=A0default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY7=
6U.4_2
>> =C2=A0default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY7=
6U.3_5
>> =C2=A0.....
>>
>> =C2=A0Please give me advices and answer on my questions
>> =C2=A01) How can I rm this "shadow" files?
>
> Consider that "shadow =C2=A0files" are rados object and are part of a=
n rados
> object. In fact when the Radosgateway stores an object in the cluster=
,
> the object is split in several parts (called chunks) and the =C2=A0si=
ze of
> each chunk is by default 4Mo. But you can configure this parameter...
> You can get more details in the online cephdocumentation
> If you want to remove these chunks =C2=A0you just =C2=A0need to remov=
e the parent
> object to which they are linked.
>> =C2=A02) What does the name of this "shadow" files?
>> =C2=A0example
>> =C2=A0with normal object:
>> =C2=A0# radosgw-admin object stat --bucket=3Ddev --object=3D"RegExp_=
tutorial.png"
>> =C2=A0and I receive information about this object.
>>
>> =C2=A0with "shadow" object:
>> =C2=A0default.4507.1_ - bucket-id
>> =C2=A0radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_t=
est_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
>> =C2=A0ERROR: failed to stat object, returned error: (2) No such file=
 or directory
>> =C2=A0how can I determine name of this object
>
> In the command above you forgot to type the full object name
> "default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.3_5=
 "
> Your command should looks like this:
> * #**rdosgw-admin object stat --bucket=3Ddev
> --object=3D"_shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
> *
> You an can have more details in inkscope project in github. We have
> implemented a module that visualizes =C2=A0and show a rados object is=
 stored
> in a Ceph cluster.
> Regards
> Alex
>
> *
> *
>> =C2=A0--
>> =C2=A0Best Regards,
>> =C2=A0Stanislav Butkeev
>> =C2=A0--
>> =C2=A0To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> =C2=A0the body of a message tomajordomo@vger.kernel.org
>> =C2=A0More majordomo info athttp://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
