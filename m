From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next hammer release v0.94.7
Date: Fri, 15 Apr 2016 07:39:38 -0700
Message-ID: <CAN=+7FXq-VSvqd3exWUB0fRSAg7DwSQgr4+dwe9n8oamDnBB2g@mail.gmail.com>
References: <570B89A3.3030006@dachary.org>
	<5710AAD2.90400@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33776 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcDOOjk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 10:39:40 -0400
Received: by mail-yw0-f181.google.com with SMTP id t10so138430450ywa.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 07:39:39 -0700 (PDT)
In-Reply-To: <5710AAD2.90400@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Looks good to me.
-Sam

On Fri, Apr 15, 2016 at 1:48 AM, Loic Dachary <loic@dachary.org> wrote:
> Ping ?
>
> On 11/04/2016 13:25, Loic Dachary wrote:
>> Hi Sam,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed the rados suite (http://tracker.ceph.com/issues/14692#n=
ote-51 and failed one test because of OpenStack specific issues but the=
 test passed in another suite with the same branch http://tracker.ceph.=
com/issues/14692#note-45) and the upgrade suite (http://tracker.ceph.co=
m/issues/14692#note-52). Do you think the hammer branch is ready for QE=
 to start their own round of testing ?
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
