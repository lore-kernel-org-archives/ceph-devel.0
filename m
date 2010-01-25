From: Sage Weil <sage@newdream.net>
Subject: Re: Caps disagreement
Date: Mon, 25 Jan 2010 11:59:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1001251152410.6859@cobra.newdream.net>
References: <a37615151001221438w431ffc0dj670ad36a3c325b1f@mail.gmail.com>
	<Pine.LNX.4.64.1001221501410.23666@cobra.newdream.net>
	<a37615151001221553g5a80f98co15da556e99785771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615151001221553g5a80f98co15da556e99785771@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Okay,

I pushed a patch that reworks this.  If the op is interrupted, we flag the 
request struct but leave it registered, so we can still process the reply.  
That processing does the caps updates, but skips the dcache changes, since 
we won't hold i_mutex anymore.  It also clears the directory's I_COMPLETE 
so that the cached readdir state is invalidated.

On Fri, 22 Jan 2010, Yehuda Sadeh Weinraub wrote:
> On Fri, Jan 22, 2010 at 3:07 PM, Sage Weil <sage@newdream.net> wrote:
> >
> > Are there other places that should be handling ERESTARTSYS?
> 
> Anywhere we have interruptible wait are the obvious places. There are
> a few places of those. I guess that we may get that when calling other
> kernel internal functions. I guess there are other places where we can
> hit it (e.g., call to kernel_recvmsg).

I left this out... AFAICS it gets translated to EINTR as long as there is 
a signal pending (which in this case there is).

Among other things, this means control-c will work again on requests 
blocked by a down MDS.

sage

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
