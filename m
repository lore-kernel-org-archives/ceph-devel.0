From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Fri, 15 Sep 2017 13:51:34 -0700
Message-ID: <CA+2bHPbTTmo4JGNr+2CR7k66MEQt3o0_yP5Cw03pZ4rL1f5gOQ@mail.gmail.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com>
 <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com>
 <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
 <87inglfqsp.fsf@suse.com> <87fubofiji.fsf@suse.com> <CA+2bHPa0QL94xckywnrF-j+k1KvZwZv4KVEzcj-DmqDFURby=Q@mail.gmail.com>
 <CAEw75dPLDAhf6SiLeR=JPwfbjoKOyS4vLOXDWj7h8-pbSCqS_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:52197 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdIOUwF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 16:52:05 -0400
Received: by mail-it0-f43.google.com with SMTP id o200so4781353itg.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 13:52:05 -0700 (PDT)
In-Reply-To: <CAEw75dPLDAhf6SiLeR=JPwfbjoKOyS4vLOXDWj7h8-pbSCqS_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Yuri Weinstein <yweinste@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

CephFS is ready!

On Fri, Sep 15, 2017 at 1:50 PM, Abhishek L
<abhishek.lekshmanan@gmail.com> wrote:
> Merged all the pending PRs that went through the run yesterday,
>
> Josh, Sage, Patrick, Yehuda are we good to go for the final QE?
>
> (We already had Jason's  approval, and #17764 & #17484 as Orit
> requested were already merged for RGW)
>
> On Fri, Sep 15, 2017 at 8:02 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> On Fri, Sep 15, 2017 at 1:54 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>> So had failures in many jobs of all the 3 suites due to an ansible
>>> failure, the fs suite, however, has a few failures in this test
>>> (tasks.cephfs.test_misc.TestMisc), is anyone aware of prior failures of
>>> this suite, can be seen in this run for eg.
>>>
>>> http://pulpito.ceph.com/abhi-2017-09-14_11:23:49-fs-wip-luminous-2017-09-14-distro-basic-smithi/1632469/
>>
>> That fs failure is known and can be ignored:
>> http://tracker.ceph.com/issues/21381
>>
>> --
>> Patrick Donnelly
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Patrick Donnelly
