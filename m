From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 8/9] fs/ceph: Eliminate useless code
Date: Wed, 20 Jan 2010 15:18:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1001201518230.29039@cobra.newdream.net>
References: <Pine.LNX.4.64.1001161659520.28745@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1001161659520.28745@ask.diku.dk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Julia Lawall <julia@diku.dk>
Cc: ceph-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 16 Jan 2010, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> The variable client is initialized twice to the same (side effect-free)
> expression.  Drop one initialization.

Applied to the ceph tree.

Thanks-
sage

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
