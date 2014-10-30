From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v0.87 Giant released
Date: Wed, 29 Oct 2014 22:54:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410292251440.27022@cobra.newdream.net>
References: <alpine.DEB.2.00.1410291454570.1234@cobra.newdream.net>
	<54517AF6.6030408@utas.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54517AF6.6030408-w4dW+7W4mDC6c6uEtOJ/EA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Nigel Williams <nigel.williams-w4dW+7W4mDC6c6uEtOJ/EA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 30 Oct 2014, Nigel Williams wrote:
> On 30/10/2014 8:56 AM, Sage Weil wrote:
> > * *Degraded vs misplaced*: the Ceph health reports from 'ceph -s' and
> >    related commands now make a distinction between data that is
> >    degraded (there are fewer than the desired number of copies) and
> >    data that is misplaced (stored in the wrong location in the
> >    cluster).
> 
> Is someone able to briefly described how/why misplaced happens please, is it
> repaired eventually? I've not seen misplaced (yet).

Sure.  An easy way to get misplaced objects is to do 'ceph osd 
out N' on an OSD.  Nothing is down, we still have as many copies 
as we had before, but Ceph now wants to move them somewhere 
else. Starting with giant, you will see the misplaced % in 'ceph -s' and 
not degraded.

> >      leveldb_write_buffer_size = 32*1024*1024  = 33554432  // 32MB
> >      leveldb_cache_size        = 512*1024*1204 = 536870912 // 512MB
> 
> I noticed the typo, wondered about the code, but I'm not seeing the same
> values anyway?
> 
> https://github.com/ceph/ceph/blob/giant/src/common/config_opts.h
> 
> OPTION(leveldb_write_buffer_size, OPT_U64, 8 *1024*1024) // leveldb write
> buffer size
> OPTION(leveldb_cache_size, OPT_U64, 128 *1024*1024) // leveldb cache size

Hmm!  Not sure where that 32MB number came from.  I'll fix it, thanks!

sage
