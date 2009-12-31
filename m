From: Sage Weil <sage@newdream.net>
Subject: Re: vi, multiple users
Date: Wed, 30 Dec 2009 20:02:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0912302001370.10847@cobra.newdream.net>
References: <a37615150912301156w2cc0bb07l3035a2176f71d0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615150912301156w2cc0bb07l3035a2176f71d0cf@mail.gmail.com>
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

On Wed, 30 Dec 2009, Yehuda Sadeh Weinraub wrote:
> There still is a problem with vi and multiple users. E.g., the following
> scenario fails:
> 
> client1: cd /mnt; cp ~/foo .
> client2: head foo
> client1: vi foo; <change something, write, exit>
> client2: head foo
> 
> now foo appears to be corrupted.
> 
> I guess it is likely that is still related to the truncation reporting that
> was found yesterday, I'll try to verify that.

BTW the corruption I was seeing was that the second page was written to 
the first page (or something very close to that, possibly shifted by a 
byte?).

sage

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
