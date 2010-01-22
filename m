From: Sage Weil <sage@newdream.net>
Subject: Re: Caps disagreement
Date: Fri, 22 Jan 2010 15:07:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1001221501410.23666@cobra.newdream.net>
References: <a37615151001221438w431ffc0dj670ad36a3c325b1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615151001221438w431ffc0dj670ad36a3c325b1f@mail.gmail.com>
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

On Fri, 22 Jan 2010, Yehuda Sadeh Weinraub wrote:
> There is a problem that I was able to reproduce quite frequently, when
> trying to untar the latest linux kernel source tree, running 'make
> oldconfig' and then 'make -j2':
> The make operation does not get through much progress and just hangs
> there after the first few steps. The problem is timing sensitive, and
> I wasn't able to reproduce it on my uml. What happens is that the mds
> and the client disagree on some directory's caps. The causes that when
> the mds sends a caps revocation request, the client ignores that
> request, since it thinks that it has already revoked the specified
> caps. Thus the mds waiting indefinitely for the client's response.

Aha!

> It seems that the root cause for the client-mds disagreement was that
> while waiting for some mds readdir operation response, the client got
> a signal (probably from another process) that made it return
> ERESTARTSYS (btw, we should translate it to EINTR) and dropped the
> actual mds response which would have updated the caps. So, a trivial
> solution would be:

Are there other places that should be handling ERESTARTSYS?  

There's commit ed03dec7, btw, which looks a lot like the below.

Also, thinking about it more, I think we may be able to make things 
interruptible and still process enough of the reply to keep things in 
sync.  The ceph_fill_trace does two different things: it processes the 
caps and updated inode info, which we can do even if it's interrupted, and 
it handles any namespace changes in the dcache, which it can't because we 
won't hold the dir i_mutex any more.  I think we'll just need to mark a 
request as aborted so that function knows the dir mutex is no longer held, 
and skips the appropriate bits.

What exactly should happen in that case for things like rename is an open 
question... probably nothing?  Presumably the request dropped the 
appropriate leases, so any subsequent operations will need to relookup the 
affected dentries?

sage



> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index abc9776..1429ed0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1605,17 +1605,15 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
>         if (!req->r_reply) {
>                 mutex_unlock(&mdsc->mutex);
>                 if (req->r_timeout) {
> -                       err = (long)wait_for_completion_interruptible_timeout(
> +                       err = (long)wait_for_completion_timeout(
>                                 &req->r_completion, req->r_timeout);
>                         if (err == 0)
>                                 req->r_reply = ERR_PTR(-EIO);
>                         else if (err < 0)
>                                 req->r_reply = ERR_PTR(err);
>                 } else {
> -                        err = wait_for_completion_interruptible(
> +                        wait_for_completion(
>                                  &req->r_completion);
> -                        if (err)
> -                                req->r_reply = ERR_PTR(err);
>                 }
>                 mutex_lock(&mdsc->mutex);
>         }
> 
> As we've already discussed that recently, the problem with that is
> that we won't be able to ^C while there are pending mds operations. We
> also need to think of some other recovery mechanism for such
> situations. E.g., instead of ignoring caps revocation request that
> (the client thinks that it) does nothing, the client should respond in
> any case.
> 
> Yehuda
> 
> ------------------------------------------------------------------------------
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for Conference
> attendees to learn about information security's most important issues through
> interactions with peers, luminaries and emerging and established companies.
> http://p.sf.net/sfu/rsaconf-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
> 
> 

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
