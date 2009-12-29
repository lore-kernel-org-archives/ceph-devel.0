From: Sage Weil <sage@newdream.net>
Subject: compat/incompat flags
Date: Mon, 28 Dec 2009 20:37:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0912282012260.1757@cobra.newdream.net>
References: <Pine.LNX.4.64.0912280905230.28566@cobra.newdream.net>
	<a37615150912281044u24bb281r5c9964e63c7327b8@mail.gmail.com>
	<1471eea70912281052j897b918n83d5355ddc7c80eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1471eea70912281052j897b918n83d5355ddc7c80eb@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

On Mon, 28 Dec 2009, Gregory Farnum wrote:
> On Mon, Dec 28, 2009 at 10:44 AM, Yehuda Sadeh Weinraub <yehudasa@gmail.com> wrote:
> > On Mon, Dec 28, 2009 at 9:24 AM, Sage Weil <sage@newdream.net> wrote:
> >> also, maybe instead of making the flags #defined bit fields, we could use
> >> strings, or something so that if you hit an incompat flag the code
> >> doesn't understand you at least have a name for it?
> >
> > Not sure if it really worth the trouble. Anyway, we could probably just
> > automate the whole flags naming/translation stuff. For example, having some
> > kind of on-disk index for the flags being used and their stringy
> > representation. For on the wire stuff it's a bit more difficult.
>
> If this becomes a long conversation we should move it to the list, but

Er, good call.

> I figured we'd do in-memory flags and transmit names along with them
> for the initial handshake so the log has something to print out if the
> handshake is coming from a more-featured implementation than the local
> daemon has.

The wire protocol change was simple (just added a new tag code and 
supported u64).  I'm not sure it's worth doing anything too complicated?  
Maybe just accompanying it with an optional string would let the server 
side say something like 'feature X not supported'.  That'd probably be 
useful in other scenarios where the protocol handshake fails.

I was mostly talking about the ondisk format flags though.  For those, we 
don't particularly care about encoding efficiency since it's just the 
superblock object.  I guess the only goal is to describe the supported 
flags in a well defined way (and get compile time errors if you mistype 
something?), and to know what you're missing if you're looking at a newer 
encoding with old code.

Does the code just need to define a single 'supported' set or is it more 
complicated than that?

sage

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
