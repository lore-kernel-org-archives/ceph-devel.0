From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next hammer release v0.94.7
Date: Thu, 21 Apr 2016 13:28:07 -0700
Message-ID: <CADRKj5TRuhxY0i4dbPkJhndtA+6qazOEWyQvSSAgN6xCKmaVRw@mail.gmail.com>
References: <570B8DEE.2020804@dachary.org>
	<5710AAE9.1020602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35492 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcDUU2J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2016 16:28:09 -0400
Received: by mail-vk0-f44.google.com with SMTP id t129so112326069vkg.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 13:28:08 -0700 (PDT)
In-Reply-To: <5710AAE9.1020602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Loic,

sorry for the late response, was out for a couple of weeks, and
managed to miss this message. Yes, it looks fine. The valgrind issue
does not look like rgw related.

On Fri, Apr 15, 2016 at 1:48 AM, Loic Dachary <loic@dachary.org> wrote:
> Ping ?
>
> On 11/04/2016 13:43, Loic Dachary wrote:
>> Hi Yehuda,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed most the rgw suite (http://tracker.ceph.com/issues/1469=
2#note-46).
>>
>> One failure is http://tracker.ceph.com/issues/15316 when seems relat=
ed to how ansible installs Amazon::S3
>> The other is a valgrind issue which seems new http://pulpito.ceph.co=
m/loic-2016-04-06_01:32:41-rgw-hammer-backports---basic-smithi/110829/
>>
>> There are runs of the rgw hammer branch on http://pulpito.ovh.sepia.=
ceph.com:8081/?branch=3Dhammer&suite=3Drgw as well but they are tainted=
 by http://tracker.ceph.com/issues/13885 which will hopefully be fixed =
by https://github.com/ceph/s3-tests/pull/104 for the next round of jewe=
l/hammer backports.
>>
>> Do you think the hammer branch is ready for QE to start their own ro=
und of testing ?
>>
>> Cheers
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
