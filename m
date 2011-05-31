From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: compile error for ceph-0.28.*.tar.gz
Date: Tue, 31 May 2011 11:48:21 -0700
Message-ID: <20110531184821.GB12733@dreamer>
References: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
 <20110531172458.GA12733@dreamer>
 <4DE52AE3.9020900@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:32778 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757814Ab1EaSsW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 14:48:22 -0400
Content-Disposition: inline
In-Reply-To: <4DE52AE3.9020900@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Simon Tian <aixt2006@gmail.com>, ceph-devel@vger.kernel.org

On Tue, May 31, 2011 at 11:52:35AM -0600, Jim Schutt wrote:
> FWIW, I believe I saw such errors on RHEL 5 due to it having
> boost v1.33.1, while Ceph needs v1.34 or newer to get statechart.

It seems we don't have a versioned dependency on libboost. I created a
ticket to make it so. Like a captain.

http://tracker.newdream.net/issues/1124

-- 
:(){ :|:&};:
