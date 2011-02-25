From: Sage Weil <sage@newdream.net>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 16:14:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102241612050.12531@cobra.newdream.net>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
 <4D669D48.6060202@dreamhost.com> <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
 <4D66A5A9.4050107@dreamhost.com> <AANLkTikWG5=hat5WgfFi0nXjswGazCPb=Cn_D3guMapO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab1BYAMt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 19:12:49 -0500
In-Reply-To: <AANLkTikWG5=hat5WgfFi0nXjswGazCPb=Cn_D3guMapO@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, 24 Feb 2011, Colin McCabe wrote:
> Updated API at http://ceph.newdream.net/git/?p=ceph.git;a=blob;f=src/include/rados/librados.hpp;h=29dec7a3143b4233fd7eb365c1e26fd3409ba6bb;hb=librados_api_cpp

 152     int selfmanaged_snap_remove(rados_pool_t pool, uint64_t snapid);

shouldn't need the rados_pool_t argument (this is a PoolHandle).

 154     int selfmanaged_snap_rollback_object(const std::string& oid, 
SnapContext& snapc,
 155                                          uint64_t snapid);

No idea what that is... probably supposed to match the C call

 123 int rados_pool_snap_rollback_object(rados_pool_t pool, const char *oid,
 124                           const char *snapname);

which should probably be called rados_rollback(), since all of the other 
object calls are just rados_foo.  Or the object calls should be 
rados_object_foo...

sage
