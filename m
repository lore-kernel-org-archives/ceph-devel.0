From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: 12.2.2 status
Date: Tue, 7 Nov 2017 06:55:34 +1100
Message-ID: <CA+2bHPbrS03kZKUA+bTD09-jArrCy2QY0wyM7ne2H+q0etk6xA@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com> <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
 <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz> <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
 <CAJE9aOP+11MR+kKDKiCQx4FQPjofBkQcecEFOJjubZX30br-Og@mail.gmail.com>
 <87y3njbuh7.fsf@suse.com> <87o9ofb6r3.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:53383 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbdKFT4G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 14:56:06 -0500
Received: by mail-qt0-f177.google.com with SMTP id n61so12465335qte.10
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 11:56:05 -0800 (PST)
In-Reply-To: <87o9ofb6r3.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: kefu chai <tchaikov@gmail.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>, vumrao@redhat.com, Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

On Tue, Nov 7, 2017 at 5:29 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
> CephFS runs seem to hit http://tracker.ceph.com/issues/22039
> consistently, the other failures look environmental. run info
> http://tracker.ceph.com/issues/21830#note-23
> @Patrick can you take a look.

Sage has a debug PR for bluestore to run with the fs suite to help
diagnose that. I'm going to queue up a run now.

-- 
Patrick Donnelly
