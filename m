From: Sage Weil <sage@inktank.com>
Subject: Re: Rados and user-provided buffers
Date: Wed, 18 Sep 2013 13:52:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309181347570.30792@cobra.newdream.net>
References: <l1d0jr$jqa$1@ger.gmane.org> <alpine.DEB.2.00.1309181259060.30792@cobra.newdream.net> <l1d2ib$hnd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36336 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab3IRUwB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Sep 2013 16:52:01 -0400
In-Reply-To: <l1d2ib$hnd$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 Sep 2013, Rutger ter Borg wrote:
> On 2013-09-18 22:01, Sage Weil wrote:
> > 
> > The read-into-existing-buffer is only wired up properly for the C
> > interface.  For the C++ it isn't generally necessary: we allocate and read
> > the data off the network,a nd pass the reference directly back to the user
> > without making another copy.  The 2010 thread is about similarly avoiding
> > such a copy for the C API.  We didn't contemplate the situation where you
> > specifically want the bytes to go to a particular address via C++.  If
> > that's what you need, the C++ API needs to be extended, or you can just
> > use the C call for that case.
> > 
> > sage
> > 
> 
> Hey Sage,
> 
> my particular use case is a pager that uses Rados as a backend. Striping of
> pages works identical to the striping mechanism of Ceph. Reads and writes of
> multiple pages may be combined into one aio_ call with one bufferlist. Pages
> are allocated by the pager.
> 
> AFAICT, the C call provides reading into a contiguous buffer, whereas I would
> like to read into a bufferlist. What would need to be done to add support for
> this in rados?

Hmm, looking at the code, I'm surprised that this isn't working.  The C 
aio_read call is just doing

  bufferlist bl;
  bufferptr bp = buffer::create_static(len, buf);
  bl.push_back(bp);

  ret = ctx->read(oid, bl, len, off);
  if (ret >= 0) {
    if (bl.length() > len)
      return -ERANGE;
    if (bl.c_str() != buf)
      bl.copy(0, bl.length(), buf);


My guess is the rx_buffers machinery is broken and we are triggering that 
bl.copy() all the time.  In principle, was is supposed to happen:

- the outbl is passed into Objecter and associated with the request.

- in Objecter::send_op(), we do

  if (op->outbl && op->outbl->length()) {
    ldout(cct, 20) << " posting rx buffer for " << op->tid << " on " << op->session->con << dendl;
    op->con = op->session->con;
    op->con->post_rx_buffer(op->tid, *op->outbl);
  }

- in msg/Pipe.cc when we are reading a message, we find that bufferliist 
and use it directly instead of allocating a new one.

      connection_state->lock.Lock();
      map<tid_t,pair<bufferlist,int> >::iterator p = connection_state->rx_buffers.find(header.tid);
      if (p != connection_state->rx_buffers.end()) {
	if (rxbuf.length() == 0 || p->second.second != rxbuf_version) {
	  ldout(msgr->cct,10) << "reader seleting rx buffer v " << p->second.second
		   << " at offset " << offset
		   << " len " << p->second.first.length() << dendl;
...

As a first step I would 'debug objecter = 20' and 'debug ms = 20' and see 
if you see those debug messages going by for a single read request.

sage
