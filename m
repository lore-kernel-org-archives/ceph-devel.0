From: Sage Weil <sweil@redhat.com>
Subject: Re: objecter functions' work
Date: Sat, 29 Aug 2015 05:20:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508290519390.13116@cobra.newdream.net>
References: <5F4E7462F2F4A14E974FBE17B8EB37210DBF7523@H3CMLB13-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-445426448-1440850836=:13116"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbH2MUh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 29 Aug 2015 08:20:37 -0400
In-Reply-To: <5F4E7462F2F4A14E974FBE17B8EB37210DBF7523@H3CMLB13-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chenxiaowei <chen.xiaowei@h3c.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-445426448-1440850836=:13116
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 29 Aug 2015, Chenxiaowei wrote:
> Hi, Sage:
> 
>          I am reading ceph osd codes, and I cannot understand some
> interface?s work(pg_ls, pg_nls, hit_set_ls, hit_set_get ),

pg_nls replaces pg_ls, and there is a new enumeration implementation 
coming in jewel that will replace htem both.

hit_set_* are implemented and shoudl work.  They're covered by the 
librados API functional tests in test/librados/tier.cc ... 
ceph_test_rados_api_* build targets.

sage


> 
> does these functions still functional? Wish your reply.
> 
>  
> 
> Shawn chen
> 
> 2015/8/29 19:04 BeiJing China.
> 
>  
> 
> ---------------------------------------------------------------------------
> ----------------------------------------------------------
> ????????????????????????????????????????
> ????????????????????????????????????????
> ????????????????????????????????????????
> ???
> This e-mail and its attachments contain confidential information from H3C,
> which is
> intended only for the person or entity whose address is listed above. Any
> use of the
> information contained herein in any way (including, but not limited to,
> total or partial
> disclosure, reproduction, or dissemination) by persons other than the
> intended
> recipient(s) is prohibited. If you receive this e-mail in error, please
> notify the sender
> by phone or email immediately and delete it!
> 
--557981400-445426448-1440850836=:13116--
