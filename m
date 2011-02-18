From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: librados api cleanup
Date: Fri, 18 Feb 2011 14:55:34 -0800
Message-ID: <20110218225534.GA7733@dreamer>
References: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
 <AANLkTim0kgb3LfhdpxXzjfxZ55eyhfWg1BtZ7RyzusQN@mail.gmail.com>
 <Pine.LNX.4.64.1102181334100.13848@cobra.newdream.net>
 <AANLkTimPR94_wEGZmvWt=X5kzYnKafDn5sUXfJdOOgKZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40618 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1BRWze (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 17:55:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimPR94_wEGZmvWt=X5kzYnKafDn5sUXfJdOOgKZ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Fri, Feb 18, 2011 at 02:49:37PM -0800, Colin McCabe wrote:
> > const char *rados_conf_get(rados_t cluster, const char *option);
> 
> I would prefer something like
> int rados_conf_get(rados_t cluster, const char *option, char **buf, int len);
> 
> We have a lot of configuration options that are ints and floats. You
> can't really return a const char* pointer to an int-- you need to make
> a temporary string somewhere, and that won't be const...

The usual idiom is to have a low-level "raw" string getter, then build
rados_conf_get_uint32, rados_conf_get_bool (e.g. understands
"yes"/"true" and "no"/"false") etc on top of that.

-- 
:(){ :|:&};:
