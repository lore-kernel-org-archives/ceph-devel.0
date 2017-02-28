From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Jewel 10.2.6 QE validation status
Date: Tue, 28 Feb 2017 15:08:54 -0800
Message-ID: <58B60306.4050400@redhat.com>
References: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdB1Xfa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 18:35:30 -0500
In-Reply-To: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>

On 02/28/2017 02:09 PM, Yuri Weinstein wrote:
> rados - one job failed, http://tracker.ceph.com/issues/18089, need Josh approval

Looks good. You can remove that failed test from the suite - dumpling is 
no longer relevant.

Josh
