From: Alexis KOALLA <alexis.koalla@orange.com>
Subject: Re: Problems with "shadow" objects
Date: Wed, 4 Mar 2015 10:47:39 +0100
Message-ID: <54F6D4BB.1030209@orange.com>
References: <1809941425380648@web25h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from r-mail1.rd.orange.com ([217.108.152.41]:17052 "EHLO
	r-mail1.rd.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945AbbCDJzY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 04:55:24 -0500
In-Reply-To: <1809941425380648@web25h.yandex.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Butkeev Stas <staerist@ya.ru>
Cc: ceph-devel@vger.kernel.org

Hi Stas,
My comments below in the mail

Le 03/03/2015 12:04, Butkeev Stas a =C3=A9crit :
> Hello, all
>
> I have ceph+RGW installation. And have some problems with "shadow" ob=
jects.
>
> For example:
> #rados ls -p .rgw.buckets|grep "default.4507.1"
>
> .....
> default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.1_5
> default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_2
> default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.6_4
> default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.4_2
> default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.3_5
> .....
>
> Please give me advices and answer on my questions
> 1) How can I rm this "shadow" files?
Consider that "shadow  files" are rados object and are part of an rados=
=20
object. In fact when the Radosgateway stores an object in the cluster,=20
the object is split in several parts (called chunks) and the  size of=20
each chunk is by default 4Mo. But you can configure this parameter...
You can get more details in the online cephdocumentation
If you want to remove these chunks  you just  need to remove the parent=
=20
object to which they are linked.
> 2) What does the name of this "shadow" files?
> example
> with normal object:
> # radosgw-admin object stat --bucket=3Ddev --object=3D"RegExp_tutoria=
l.png"
> and I receive information about this object.
>
> with "shadow" object:
> default.4507.1_ - bucket-id
> radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_test_s3.=
2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
> ERROR: failed to stat object, returned error: (2) No such file or dir=
ectory
> how can I determine name of this object
In the command above you forgot to type the full object name=20
"default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.3_5 "
Your command should looks like this:
* #**rdosgw-admin object stat --bucket=3Ddev=20
--object=3D"_shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
*
You an can have more details in inkscope project in github. We have=20
implemented a module that visualizes  and show a rados object is stored=
=20
in a Ceph cluster.
Regards
Alex

*
*
> --=20
> Best Regards,
> Stanislav Butkeev
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message tomajordomo@vger.kernel.org
> More majordomo info athttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
