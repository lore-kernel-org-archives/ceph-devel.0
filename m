From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
Date: Wed, 01 Mar 2017 22:24:36 -0500
Message-ID: <yq1zih4pdhn.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
        <yq1efyq25y2.fsf@oracle.com>
        <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
        <yq1fuj44geq.fsf@oracle.com>
        <CAOi1vP_g-MMe9XvWDgkVL4R6UjckMQVC_CDF9+hQEpZbxwx0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_g-MMe9XvWDgkVL4R6UjckMQVC_CDF9+hQEpZbxwx0Jw@mail.gmail.com>
        (Ilya Dryomov's message of "Tue, 28 Feb 2017 09:19:14 +0100")
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:

Ilya,

Ilya> Given the above, I'm not sure what the baseline is --
Ilya> blk_integrity code isn't invoked for data-only lbafs.  Could nvme
Ilya> folks please look at this?  rbd regression caused by integrity
Ilya> revalidate change goes back to 4.4 and I'd really like to get it
Ilya> fixed.  The proposed patch is attached to my earlier reply on
Ilya> linux-block.

I've had a couple of fires to attend to this week. I'll try and give
your patch a spin on my FC setup tomorrow or Friday.

-- 
Martin K. Petersen	Oracle Linux Engineering
