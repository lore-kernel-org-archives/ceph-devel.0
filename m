From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: block-rbd: One function call less in rbd_dev_probe_parent() after
 error detection
Date: Tue, 24 Nov 2015 22:54:17 +0100
Message-ID: <CAOi1vP_MoqiPqNMGJVEeAyBywtkHbZrn7cLayEgdT1cL63c7KQ@mail.gmail.com>
References: <5307CAA2.8060406@users.sourceforge.net>
	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	<530A72AA.3000601@users.sourceforge.net>
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
	<5317A59D.4@users.sourceforge.net>
	<56536BAD.4000309@users.sourceforge.net>
	<56536D12.4000308@users.sourceforge.net>
	<CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
	<5654B91D.4040808@users.sourceforge.net>
	<CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
	<5654C9F2.20409@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5654C9F2.20409@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 24, 2015 at 9:34 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Well, there isn't any _literal_ linking (e.g. adding to a link list,
>> etc) in this case.  We just bump some refs and do probe to fill in the
>> newly allocated parent.
>
> Thanks for your clarification.
>
>
>> The actual linking (rbd_dev->parent = parent) is done right before
>> returning so we never have to undo it in rbd_dev_probe_parent() and
>> that's the only reason your patch probably doesn't break anything.
>
> Is this function implementation just also affected by an issue
> which is mentioned in the Linux document "CodingStyle" as "one err bugs"?

No, why?  "one err bug" as per CodingStyle is a NULL deref on line 2 if
foo is NULL.  If it was just "err: kfree(foo); return ret;", a NULL foo
would be perfectly OK.

1       err:
2               kfree(foo->bar);
3               kfree(foo);
4               return ret;

If you can spot such a NULL deref in rbd_dev_probe_parent(), I'd gladly
take a patch.

>
>
>> Think about what happens if, after your patch is applied, someone moves
>> that assignment up or adds an extra step that can fail after it...
>
> Is such a software maintenance concern really enough to delay (or reject)
> my second update suggestion in this small patch series?

Yes - it's rejected because it messes up the order of cleanup for no
good reason.  I realize why you think the patch is correct and it's not
without merit, but it just doesn't fit the weird rbd_dev_probe_parent()
contract.

Thanks,

                Ilya
