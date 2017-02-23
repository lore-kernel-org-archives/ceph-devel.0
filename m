From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
Date: Thu, 23 Feb 2017 18:49:01 -0500
Message-ID: <yq1fuj44geq.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
        <yq1efyq25y2.fsf@oracle.com>
        <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
        (Ilya Dryomov's message of "Wed, 22 Feb 2017 15:41:43 +0100")
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: ceph-devel.vger.kernel.org

>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:

Ilya,

Ilya> Well, blk_integrity_revalidate() doesn't clear the profile, it
Ilya> just clears the stable pages flag.  Whoever calls
Ilya> blk_integrity_unregister() to clear the profile can also clear the
Ilya> stable pages flag -- why not let blk_integrity_unregister() clear
Ilya> the flag like I suggested?

That's what it used to do.

blk_integrity_revalidate() was obviously introduced to overcome some
problem. Unfortunately, I can't recall what that was and Google isn't
being particularly helpful. I suspect it was either in the NVDIMM or
NVMe camps since that's where the churn was.

I don't have a problem with your patch as long as we're sure there are
no regressions. I would carry the gendisk check over, though.

-- 
Martin K. Petersen	Oracle Linux Engineering
