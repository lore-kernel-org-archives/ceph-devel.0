From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Caps disagreement
Date: Fri, 22 Jan 2010 15:53:36 -0800
Message-ID: <a37615151001221553g5a80f98co15da556e99785771@mail.gmail.com>
References: <a37615151001221438w431ffc0dj670ad36a3c325b1f@mail.gmail.com>
	<Pine.LNX.4.64.1001221501410.23666@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1001221501410.23666@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jan 22, 2010 at 3:07 PM, Sage Weil <sage@newdream.net> wrote:
>
> Are there other places that should be handling ERESTARTSYS?

Anywhere we have interruptible wait are the obvious places. There are
a few places of those. I guess that we may get that when calling other
kernel internal functions. I guess there are other places where we can
hit it (e.g., call to kernel_recvmsg).

>
> There's commit ed03dec7, btw, which looks a lot like the below.
Yeah.. sadly (or luckily) I'm on a different branch. This would have solved=
 it.

>
> Also, thinking about it more, I think we may be able to make things
> interruptible and still process enough of the reply to keep things in
> sync. =A0The ceph_fill_trace does two different things: it processes the
> caps and updated inode info, which we can do even if it's interrupted, and
> it handles any namespace changes in the dcache, which it can't because we
> won't hold the dir i_mutex any more. =A0I think we'll just need to mark a
> request as aborted so that function knows the dir mutex is no longer held,
> and skips the appropriate bits.
We should probably just be doing our best effort with what we got.
This specific bug wouldn't have happened had we updated the caps. Not
sure about namespace changes, maybe being able to mark the dir invalid
without needing to hold the i_mutex?

>
> What exactly should happen in that case for things like rename is an open
> question... probably nothing? =A0Presumably the request dropped the
> appropriate leases, so any subsequent operations will need to relookup the
> affected dentries?
Yeah, probably. I don't think that such a scenario where the mds and
the client don't agree on a file's name is possible, since the client
dropped the relevant lease for the rename. However we shouldn't rely
on the specific operation implementation, and we should make sure that
we can either mark the directory or the relevant dentries as invalid.

Yehuda

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
