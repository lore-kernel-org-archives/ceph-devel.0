From: Loic Dachary <ldachary@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Mon, 12 Sep 2016 22:00:13 +0200
Message-ID: <57D7094D.9050400@redhat.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
 <CAMMFjmFRHAu8cPpLatorQ_LZ_5fcAbA082ivT1N7bA9Qr_qgdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbcILUAS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 16:00:18 -0400
In-Reply-To: <CAMMFjmFRHAu8cPpLatorQ_LZ_5fcAbA082ivT1N7bA9Qr_qgdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>



On 09/09/2016 20:19, Yuri Weinstein wrote:
> Ticket http://tracker.ceph.com/issues/16344#note-46 updated with dev
> leads approvals (pls review) as following (suites marked with * still
> need decision/fix):
>
> rados:
>    http://tracker.ceph.com/issues/16516 (approved by DavidZ)
>
> rbd:
>    multiple issues (Approved by Jason)
>
> krbd:
>    http://tracker.ceph.com/issues/17223
>    http://tracker.ceph.com/issues/17221
>    http://tracker.ceph.com/issues/17222
>    (Approved by Ilya)
>
> * knfs
>    http://tracker.ceph.com/issues/17192
>    (Greg pls review/approve, note: it's similar we saw in hammer point release)
>
> * samba:
>    http://tracker.ceph.com/issues/17184
>    (Greg pls review/approve)
>
> upgrade/client-upgrade:about:startpage
>    http://tracker.ceph.com/issues/16506
>    (Approved by Loic)
>
> upgrade/infernalis-x (jewel):
>    http://tracker.ceph.com/issues/17176
>    (Approved by Loic)
>
> * powercycle:
>    http://tracker.ceph.com/issues/17177
>    (Sage  pls review/approve)
>
> * ceph-disk
>    http://tracker.ceph.com/issues/17114
>    http://tracker.ceph.com/issues/17100
>    (Loic  pls review/approve)
I confirm that these problems are related to the test suite and not ceph-disk executable. Therefore they are not, in my opinion, blockers for the jewel release.

Cheers
> Thx
> YuriW
>
> On Tue, Sep 6, 2016 at 10:12 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/16344#note-46
>>
>> The following suites were in scope of this point release validation:
>>
>> rados (subset 35/50 297 jobs)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> rest
>> hadoop
>> samba
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/hammer-x (jewel)
>> upgrade/infernalis-x (jewel)
>> powercycle
>> (please let me know if any suites are missing from this ^ list)
>>
>> ==============================
>> Issues requiring approval/decision:
>>
>> rados:
>>    http://tracker.ceph.com/issues/16516 (approved by DavidZ)
>>
>> rbd:
>>    multiple issues (Jason pls rview/approve, see notes
>> http://tracker.ceph.com/issues/16344#note-46)
>>
>> krbd:
>>    http://tracker.ceph.com/issues/17223
>>    http://tracker.ceph.com/issues/17221
>>    http://tracker.ceph.com/issues/17222
>>    (Jason pls rview/approve)
>>
>> knfs
>>    http://tracker.ceph.com/issues/17192
>>    (Greg pls rview/approve, note: it's similar we saw in hammer point release)
>>
>> samba:
>>    http://tracker.ceph.com/issues/17184
>>    (Greg pls rview/approve)
>>
>> upgrade/client-upgrade:about:startpage
>>    http://tracker.ceph.com/issues/16506
>>    (Sage, Sam, Jason pls rview/approve)
>>
>> upgrade/infernalis-x (jewel):
>>    http://tracker.ceph.com/issues/17176
>>    (Sam, David  pls rview/approve)
>>
>> powercycle:
>>    http://tracker.ceph.com/issues/17177
>>    (Sage  pls rview/approve)
>>
>> Loic, given that we have high number of issues in this release, if you
>> and dev leads find that we need to add more backports we may consider
>> validating a new point RC (sha1).
>>
>> Thx
>> YuriW

