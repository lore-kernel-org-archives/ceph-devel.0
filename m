From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Wed, 13 Apr 2016 16:20:05 +0200
Message-ID: <20160413162005.37b9f516@bahia.huguette.org>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
	<20160407175030.5b6f2edb@bahia.huguette.org>
	<5709F8FB.1040005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:60378 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031214AbcDMOUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 10:20:21 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Wed, 13 Apr 2016 15:20:19 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCF0A2190046
	for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 15:19:48 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3DEK9T466650222
	for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 14:20:09 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3DEK8wU008204
	for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 10:20:09 -0400
In-Reply-To: <5709F8FB.1040005@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, ceph-devel@vger.kernel.org, gfarnum@redhat.com

Hi Jevon,

On Sun, 10 Apr 2016 14:55:55 +0800
Jevon Qiao <scaleqiao@gmail.com> wrote:

> Hi Greg,
> 
> Thank you for spending time reviewing this patch.
> On 7/4/16 23:50, Greg Kurz wrote:
> > On Tue, 15 Mar 2016 00:02:48 +0800
> > Jevon Qiao <scaleqiao@gmail.com> wrote:
> >  
> >> Ceph as a promising unified distributed storage system is widely used in the
> >> world of OpenStack. OpenStack users deploying Ceph for block (Cinder) and
> >> object (S3/Swift) are unsurprisingly looking at Manila and CephFS to round out
> >> a unified storage solution. Since the typical hypervisor people are using is
> >> Qemu/KVM, it is necessary to provide a high performance, easy to use, file
> >> system service in it. VirtFS aims to offers paravirtualized system services and
> >> simple passthrough for directories from host to guest, which currently only
> >> support local file system, this patch wants to add CephFS support in VirtFS.
> >>
> >> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
> >> ---  
> > Jevon,
> >
> > There's still work to be done on this patch.
> >
> > One general remark is that there are far too many traces: it obfuscates the code
> > and does not bring much benefit in my opinion. If you look at the other fsdev
> > drivers, you see they don't do traces at all !
> > Also, I've found several errors where the code simply cannot work... please run
> > a file/io oriented testsuite in the guest to check all the fsdev operations are
> > working as expected... maybe some tests from LTP ?  

Please leave at least one empty line before...

> Well, I did run some tests against this patch with iozone to guarantee 
> the IO path is correct and did some manual tests to make sure that the 
> basic file/directory operations work. Anyway, I will run the file system 
> related parts of LTP.

... and after your comments, so that we see them well.

Unless I've missed something, you had only one question.

> [...]
> >> +#ifndef HAVE_CEPH_READV
> >> +static ssize_t ceph_preadv(struct ceph_mount_info *cmount, int fd,
> >> +                           const struct iovec *iov, int iov_cnt,
> >> +                           off_t offset)
> >> +{
> >> +    ssize_t ret;
> >> +    size_t i;
> >> +    size_t len, tmp;
> >> +    void *buf;
> >> +    size_t bufoffset = 0;
> >> +
> >> +    len = iov_size(iov, iov_cnt);
> >> +    buf = g_new0(uint8_t, len);
> >> +    ret = ceph_read(cmount, fd, buf, len, offset);
> >> +    if (ret < 0) {
> >> +        return ret;  
> > buf is leaked.
> >  
> >> +    } else {
> >> +        tmp = ret;
> >> +        for (i = 0; (i < iov_cnt && tmp > 0); i++) {  
> > tmp is <= to the sum of all iov_len: unless I miss something, it
> > isn't possible for i to reach iov_cnt. Also the parenthesis aren't
> > needed.  
> So do you mean only tmp>0 is needed here?

That's my point, yes.

Cheers.

--
Greg

