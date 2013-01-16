From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Wed, 16 Jan 2013 15:09:18 +0100
Message-ID: <50F6B48E.6000003@univ-nantes.fr>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com> <CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com> <CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com> <CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com> <CA+-7kDCODuG-mWXEHv_QFdo1Guow55dd55+yPz85hKN+5rU1Gw@mail.gmail.com> <CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com> <CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com> <CA+-7kDCLhNx3QQ3OUGxrKT6VJszyPuPdgceA8C-pqYZRBqKkZQ@mail.gmail.com> <50F686A2.2060901@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:39898 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342Ab3APOQs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 09:16:48 -0500
In-Reply-To: <50F686A2.2060901@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Marcin Szukala <szukala.marcin@gmail.com>, ceph-devel@vger.kernel.org

Le 16/01/2013 11:53, Wido den Hollander a =E9crit :
>
>
> On 01/16/2013 11:50 AM, Marcin Szukala wrote:

>> Hi all,
>>
>> Any ideas how can I resolve my issue? Or where the problem is?
>>
>> Let me describe the issue.
>> Host boots up and maps RBD image with XFS filesystems
>> Host mounts the filesystems from the RBD image
>> Host starts to write data to the mounted filesystems
>> Host experiences power failure
you are not doing sync there, right ?

>> Host comes up and map the RBD image
>> Host mounts the filesystems from the RBD image
>> All data from all filesystems is lost
>> Host is able to use the filesystems with no problems.
>>
>> Filesystem is XFS, no errors on filesystem,

you MAY have hit an XFS issue.

Please follow XFS list, in particular this thread :
http://oss.sgi.com/pipermail/xfs/2012-December/023021.html

If i Remember well, this one is after 3.4 kernel, and I think the fix=20
isn't in the current ubuntu kernel.


cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
