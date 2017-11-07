From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: 12.2.2 status
Date: Tue, 7 Nov 2017 18:51:21 -0500
Message-ID: <CAKOnarnE60oX8vjVg=2rAOW_DnRQ9jhOXVjYOc57ujMtYYjdjg@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com> <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
 <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz> <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
 <CAJE9aOP+11MR+kKDKiCQx4FQPjofBkQcecEFOJjubZX30br-Og@mail.gmail.com>
 <87y3njbuh7.fsf@suse.com> <87o9ofb6r3.fsf@suse.com> <CA+2bHPbrS03kZKUA+bTD09-jArrCy2QY0wyM7ne2H+q0etk6xA@mail.gmail.com>
 <9496514c2bbb59c5cc05bf48a47372de@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:43459 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758283AbdKGXvW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 18:51:22 -0500
Received: by mail-it0-f49.google.com with SMTP id k70so7665134itk.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Nov 2017 15:51:22 -0800 (PST)
In-Reply-To: <9496514c2bbb59c5cc05bf48a47372de@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, kefu chai <tchaikov@gmail.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>, Vikhyat Umrao <vumrao@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, Karol Mroz <KMroz@suse.com>, Yuri Weinstein <yweinste@redhat.com>, ceph-devel-owner@vger.kernel.org

I think that's everything.

Matt

On Tue, Nov 7, 2017 at 4:59 PM, Abhishek <abhishek@suse.com> wrote:
> On 2017-11-06 20:55, Patrick Donnelly wrote:
>>
>> On Tue, Nov 7, 2017 at 5:29 AM, Abhishek Lekshmanan <abhishek@suse.com>
>> wrote:
>>>
>>> CephFS runs seem to hit http://tracker.ceph.com/issues/22039
>>> consistently, the other failures look environmental. run info
>>> http://tracker.ceph.com/issues/21830#note-23
>>> @Patrick can you take a look.
>>
>>
>> Sage has a debug PR for bluestore to run with the fs suite to help
>> diagnose that. I'm going to queue up a run now.
>
>
> This is the final list of PRs that we have pending merge onto Luminous:
>
> QE
> https://github.com/ceph/ceph/pull/18702 (good to go)
> RBD:
> https://github.com/ceph/ceph/pull/18564 (waiting on jenkins for clicking the
> big green button)
>
> RGW
> https://github.com/ceph/ceph/pull/18794
> https://github.com/ceph/ceph/pull/18800
> https://github.com/ceph/ceph/pull/18801
>
>
> Assuming these are merged in,
> Patrick, Jason, John, Josh & Yehuda/Matt, do we need anything else for
> 12.2.2 before handing over to QE for the final round of testing?
>
> Best,
> Abhishek



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
