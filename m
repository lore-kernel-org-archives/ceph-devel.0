From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: kvm driver
Date: Mon, 8 Mar 2010 22:04:26 -0800
Message-ID: <a37615151003082204p6f1620fbt7a7bbc942e42a7d1@mail.gmail.com>
References: <20100308054150.GA40223@ncolin.muc.de>
	<Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Christian Brunner <chb@muc.de>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 8, 2010 at 2:18 PM, Sage Weil <sage@newdream.net> wrote:
>
> Yehuda is taking a look at it now. =A0The signals are used to wake up
> blocking read()/write()/connect(), but we should be able to use poll() or
> select() instead (and clean things up in the process).
>

A fix was pushed to the unstable branch.

Thanks,
Yehuda

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
