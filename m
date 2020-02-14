From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: Readiness for 14.2.8 ?
Date: Fri, 14 Feb 2020 18:15:54 +0100
Message-ID: <20200214171554.l7ibzoo64uthd2ke@jfsuselaptop>
References: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:47154 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387509AbgBNRh5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:37:57 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR ceph-devel@vger.kernel.org;
 Fri, 14 Feb 2020 17:36:47 +0000
Content-Disposition: inline
In-Reply-To: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Neha Ojha <nojha@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, "Weil, Sage" <sweil@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>

On Mon, Feb 10, 2020 at 11:57:19AM -0800, Yuri Weinstein wrote:
>Below is the current queue of PRs:
>https://github.com/ceph/ceph/pulls?page=2&q=is%3Aopen+label%3Anautilus-batch-1+label%3Aneeds-qa
>
>Most PRs are being tested.
>Unless there are objections, we will start QE validation as soon as
>all PRs in this queue were merged.
>
>Dev leads - pls add and tag all RRs that must be included.
ceph-volume is ready, al backports are merged and tested (thank you Nathan!).
>
>Thx
>YuriW
>

-- 
Jan Fajerski
Senior Software Engineer Enterprise Storage
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
