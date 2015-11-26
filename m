From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: block-rbd: One function call less in rbd_dev_probe_parent() after
 error detection
Date: Thu, 26 Nov 2015 14:41:32 +0100
Message-ID: <56570C0C.5050402@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <56536BAD.4000309@users.sourceforge.net>
 <56536D12.4000308@users.sourceforge.net>
 <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
 <5654B91D.4040808@users.sourceforge.net>
 <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
 <5656BAC5.3060501@users.sourceforge.net>
 <CAOi1vP-p8jSee8hEprH1eowDY4daSR0zjTgDpbyF6=vJRXTr1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP-p8jSee8hEprH1eowDY4daSR0zjTgDpbyF6=vJRXTr1g@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

>> * Why was the function "rbd_dev_probe_parent" implemented in the way
>>   that it relies on a sanity check in the function "rbd_dev_destroy" then?
> 
> Because it's not a bad thing?

There are different opinions about this implementation detail.


> What's wrong with an init to NULL, a possible assignment, in this case
> from rbd_dev_create(), and an unconditional rbd_dev_destroy()?

Does this approach look like it is affected by a "one error jump
label bug" symptom?


> The NULL check in rbd_dev_destroy() is not a sanity check,
> it's a feature.

I have got an other impression here.


> It's not there to "fixup" callers that pass NULL

It seems that the explanations on the detail why a function tolerates
passed null pointers can also be different.


> - it's there because it is _expected_ that some callers will pass NULL.

I find it still unnecessary to let a called function like "rbd_dev_destroy"
to repeat the check when you know already that the passed variable contains
a null pointer.


> As I said in my reply to Dan, the problem with rbd_dev_probe_parent()
> is the calling code which expects it to call unparent if ->parent_spec.
> This makes it stand out and confuses people, but can't be fixed without
> refactoring a bunch of other code.

I would appreciate if the discussed function could be also improved by itself.
More refactoring might follow at other source code places later.


> The extra function call is *not* a problem.

How many software developers and reviewers will care if corresponding
error handling can also become a bit more efficient?

Regards,
Markus
