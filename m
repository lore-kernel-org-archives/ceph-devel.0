From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel 10.2.6 QE validation status
Date: Wed, 1 Mar 2017 16:54:58 +0100
Message-ID: <768044da-ed56-d24e-10d0-c838d7b0937f@suse.cz>
References: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
 <alpine.DEB.2.11.1703010039050.25760@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52797 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752518AbdCAPzZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Mar 2017 10:55:25 -0500
In-Reply-To: <alpine.DEB.2.11.1703010039050.25760@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>, David Galloway <dgallowa@redhat.com>

>> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/18089, can
>> be approved for release, Sage?
>
> If you mean it's just hte xenial nodes failing on the package install,
> yeah, ignore those failures!

No, #18089 is a different problem - the subject line captures it 
reasonably well: "No way to prevent Chacra from deleting builds, breaks 
a number of upgrade tests". David Galloway is working on it.

Nathan
