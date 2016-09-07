From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph v10.2.3 QE validation status
Date: Wed, 7 Sep 2016 08:33:56 +0200
Message-ID: <57CFB4D4.1060706@dachary.org>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
 <CAMMFjmFBW+Zdnx8Ux9mtKvh3W187oHL3UDqNpKtkHZ15Q=porg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50520 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbcIGGeG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 02:34:06 -0400
In-Reply-To: <CAMMFjmFBW+Zdnx8Ux9mtKvh3W187oHL3UDqNpKtkHZ15Q=porg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

Hi Yuri,

The deph-disk suite must be run on VPS.

Cheers

On 06/09/2016 22:26, Yuri Weinstein wrote:
> Missed a line with ceph-disk issue -
> 
> ceph-disk:
>    http://tracker.ceph.com/issues/15350
>    (Loic, Sam pls review/approve)
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
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
