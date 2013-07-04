From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: wip-libcephfs rebased and pulled up to v.65
Date: Thu, 4 Jul 2013 12:28:26 -0400 (EDT)
Message-ID: <1516993097.44.1372955306422.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1307031439270.3375@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2219 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525Ab3GDQ2b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Jul 2013 12:28:31 -0400
In-Reply-To: <alpine.DEB.2.00.1307031439270.3375@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>

Sure.  Let us know if you'd like us to do anything in the window.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hi Matt,
> 
> This hit a problem in QA.. running 
> ceph.git/qa/workunits/kernel_untar_build.sh on ceph-fuse crashes with
> 
> 2013-07-03 12:51:14.176096 7fae7ee93780 10 client.4106 _lookup
> 10000004031.head(ref=4 cap_refs={} open={} mode=40775 size=0
> mtime=2012-02-29 16:32:49.000000 caps=pAsLsXsFsx(0=pAsLsXsFsx)
> dirty_caps=Fx parents=0x9be18c0 0x9b4a000) generated =
> 1000000a29d.head(ref=3 cap_refs={} open={} mode=40775 size=0
> mtime=2013-07-03 12:43:25.748972 caps=pAsLsXsFsx(0=pAsLsXsFsx)
> parents=0x8e909a0 0xa3b3d80)
> 2013-07-03 12:51:14.176126 7fae7ee93780 10 client.4106 fill_stat on
> 1000000a29d snap/devhead mode 040775 mtime 2013-07-03 12:43:25.http://www.mindspring.com/~ffilz/748972
> ctime 2013-07-03 12:43:25.748972
> 2013-07-03 12:51:14.176135 7fae7ee93780  3 client.4106 ll_lookup
> 0x9b4a000 generated -> 0 (1000000a29d)
> 2013-07-03 12:51:14.176148 7fae7ee93780  3 client.4106 ll_forget
> 10000004031 1
> 2013-07-03 12:51:14.191582 7fae7ee93780 -1 *** Caught signal
> (Segmentation fault) **
>  in thread 7fae7ee93780
> 
>  ceph version 0.65-250-gfcf46bc
> (fcf46bc56dc37a90f69f6609e2ff3216d9195d2f)
>  1: ceph-fuse() [0x7937fa]
>  2: (()+0xfcb0) [0x7fae7e843cb0]
>  3: (Client::_get_inodeno(Inode*)+0) [0x529a70]
>  4: (Client::ll_forget(Inode*, int)+0x4a) [0x534a6a]
>  5: ceph-fuse() [0x5261f5]
>  6: (fuse_session_loop()+0x75) [0x7fae7ea61d65]
>  7: (main()+0x848) [0x5228f8]
>  8: (__libc_start_main()+0xed) [0x7fae7cd0676d]
>  9: ceph-fuse() [0x523df9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> It wasn't immediately obvious what the problem is except that it
> looked 
> like a (ll_)refcounting issue.  Also, the special-case of 'forget on
> root' 
> looks suspicous; I'd like to pull in the patch from Ilya that takes a
> ref 
> in the get_root_inode() method and make the refcounting uniform.
> 
> Thanks!
> sage
> 
> 
> On Tue, 2 Jul 2013, Matt W. Benjamin wrote:
> 
> > Hi Sage (et al),
> > 
> > We have rebased the former wip-libcephfs branch, on the model of
> the
> > rebased example branch, as planned, and also pulled it up to Ceph's
> > v65 tag/master, also as planned.
> > 
> > In addition to cross checking this, Adam has updated our Ganesha
> client
> > driver to use the ll v2 API, and this checks out.
> > 
> > We've pushed wip-libcephfs-rebased-v65 to our public git
> repository,
> > https://github.com/linuxbox2/linuxbox-ceph, for review.
> > 
> > Thanks,
> > 
> > Matt
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> >

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
