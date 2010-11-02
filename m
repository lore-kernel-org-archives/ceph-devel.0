From: Ted Ts'o <tytso@mit.edu>
Subject: Re: osd sequence number mismatches and timeout's
Date: Tue, 2 Nov 2010 11:29:16 -0400
Message-ID: <20101102152916.GC25614@thunk.org>
References: <E1PD2eA-0005Tn-G4@tytso-glaptop>
 <Pine.LNX.4.64.1011011549520.26372@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:41529 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab0KBP3Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Nov 2010 11:29:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011011549520.26372@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Nov 01, 2010 at 03:57:55PM -0700, Sage Weil wrote:
> Is there something in dmesg before the osd22 seq number errors pop up?  

Yup, you were quite right.  There was a bad crc that probably caused
the seq's to get out of sync.

Nov  1 10:12:50 bdio20 kernel: [233439.052725] ceph: osd22 10.138.138.13:6804 bad crc
Nov  1 10:12:51 bdio20 kernel: [233440.672738] ceph: skipping osd22 192.168.168.13:6804 seq 1, expected 2
Nov  1 10:12:51 bdio20 kernel: [233440.672958] ceph: skipping osd22 192.168.168.13:6804 seq 2, expected 3
Nov  1 10:12:51 bdio20 kernel: [233440.675705] ceph: skipping osd22 192.168.168.13:6804 seq 3, expected 4

> Something originally caused the seq's to get out of sync.  I suspect it 
> was a transient network error that made the TCP session drop and 
> reconnect, and it's not skipping already-received messages.  There was a 
> bug in the skip code (so they stayed out of sync and osd22 eventually 
> timed out).  I pushed a fix for that to the ceph-client.git master branch 
> (df9f86fa).

BTW, it looks like something may be unhappy?  I tried doing a clone of
ceph-client.git, and I'm getting a failure:

% git clone git://ceph.newdream.net/git/ceph-client.git ceph-client
Cloning into ceph-client...
fatal: I don't handle protocol '/usr/local/google/git'

I downloaded df9f86fa and will try it out.  Thanks for pushing out the
patch so quickly!

					- Ted
