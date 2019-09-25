From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RADOS EC: is it okay to reduce the number of
 commits required for reply to client?
Date: Wed, 25 Sep 2019 14:00:38 -0700
Message-ID: <CAJ4mKGY0g00sZCpn-BEBh+ohNkeC6K56bNFbXVRurHWcfEzd2g@mail.gmail.com>
References: <CAPHfcngzug4HDzHtZcb80xdf-NZFNjc2Q7r3vJWSHJufjcgKKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPHfcngzug4HDzHtZcb80xdf-NZFNjc2Q7r3vJWSHJufjcgKKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alex Xu <alexu4993-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 19, 2019 at 12:06 AM Alex Xu <alexu4993-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Cephers,
>
> We are testing the write performance of Ceph EC (Luminous, 8 + 4), and
> noticed that tail latency is extremly high. Say, avgtime of 10th
> commit is 40ms, acceptable as it's an all HDD cluster; 11th is 80ms,
> doubled; then 12th is 160ms, doubled again, which is not so good. Then
> we made a small modification and tested again, and did get a much
> better result. The patch is quite simple (for test only of course):
>
> --- a/src/osd/ECBackend.cc
> +++ b/src/osd/ECBackend.cc
> @@ -1188,7 +1188,7 @@ void ECBackend::handle_sub_write_reply(
>      i->second.on_all_applied = 0;
>      i->second.trace.event("ec write all applied");
>    }
> -  if (i->second.pending_commit.empty() && i->second.on_all_commit) {
> +  if (i->second.pending_commit.size() == 2 &&
> i->second.on_all_commit) {  // 8 + 4 - 10 = 2
>      dout(10) << __func__ << " Calling on_all_commit on " << i->second << dendl;
>      i->second.on_all_commit->complete(0);
>      i->second.on_all_commit = 0;
>
> As far as what I see, everything still goes well (maybe because of the
> rwlock in primary OSD? not sure though), but I'm afraid it might break
> data consistency in some ways not aware of. So I'm writing to ask if
> someone could kindly provide expertise comments on this or maybe share
> any known drawbacks. Thank you!

Unfortunately this is one of those things that will work okay in
everyday use but fail catastrophically if something else goes wrong.

Ceph assumes throughout its codebase that if a write committed to
disk, it can be retrieved as long as k OSDs are available from the
PG's acting set when that write was committed. But by letting writes
"commit" on less than the full acting set, you might lose some of the
OSDs which *did* ack the write and no longer be able to find out what
it was even though you have >k OSDs available!

This will result in a very, very confused Ceph recovery algorithm,
lots of badness, and unhappy cluster users. :(
-Greg

>
> PS: OSD is backended with filestore, not bluestore, if that matters.
>
> Regards,
> Alex
