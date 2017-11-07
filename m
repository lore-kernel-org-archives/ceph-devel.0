From: Abhishek <abhishek@suse.com>
Subject: Re: 12.2.2 status
Date: Tue, 07 Nov 2017 22:59:09 +0100
Message-ID: <9496514c2bbb59c5cc05bf48a47372de@suse.com>
References: <87fua6c4xy.fsf@suse.com>
 <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com>
 <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com>
 <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
 <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz>
 <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
 <CAJE9aOP+11MR+kKDKiCQx4FQPjofBkQcecEFOJjubZX30br-Og@mail.gmail.com>
 <87y3njbuh7.fsf@suse.com> <87o9ofb6r3.fsf@suse.com>
 <CA+2bHPbrS03kZKUA+bTD09-jArrCy2QY0wyM7ne2H+q0etk6xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbdKGV7L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Nov 2017 16:59:11 -0500
In-Reply-To: <CA+2bHPbrS03kZKUA+bTD09-jArrCy2QY0wyM7ne2H+q0etk6xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>, vumrao@redhat.com, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, Karol Mroz <KMroz@suse.com>, yweinste@redhat.com, ceph-devel-owner@vger.kernel.org

On 2017-11-06 20:55, Patrick Donnelly wrote:
> On Tue, Nov 7, 2017 at 5:29 AM, Abhishek Lekshmanan <abhishek@suse.com> 
> wrote:
>> CephFS runs seem to hit http://tracker.ceph.com/issues/22039
>> consistently, the other failures look environmental. run info
>> http://tracker.ceph.com/issues/21830#note-23
>> @Patrick can you take a look.
> 
> Sage has a debug PR for bluestore to run with the fs suite to help
> diagnose that. I'm going to queue up a run now.

This is the final list of PRs that we have pending merge onto Luminous:

QE
https://github.com/ceph/ceph/pull/18702 (good to go)
RBD:
https://github.com/ceph/ceph/pull/18564 (waiting on jenkins for clicking 
the big green button)

RGW
https://github.com/ceph/ceph/pull/18794
https://github.com/ceph/ceph/pull/18800
https://github.com/ceph/ceph/pull/18801


Assuming these are merged in,
Patrick, Jason, John, Josh & Yehuda/Matt, do we need anything else for 
12.2.2 before handing over to QE for the final round of testing?

Best,
Abhishek
