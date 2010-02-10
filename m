From: Sage Weil <sage@newdream.net>
Subject: Re: Write operation is stuck
Date: Wed, 10 Feb 2010 13:39:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "Talyansky, Roman" <roman.talyansky@sap.com>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Hi Roman,

On Wed, 10 Feb 2010, Talyansky, Roman wrote:

> Hello,
> 
> Recently I ran three application  instances simultaneously over a mounted CEPH file system and one of them got stuck calling a write operation.
> I had the following CEPH configuration:
> -       The nodes have Debian installation - lenny  , unstable
> -       Three nodes with osd servers
> -       Three client nodes
> -       One client node among the three mentioned above was located at a node where an osd server ran.
> 
> Can the origin of the problem be the client collocated with an osd server?

The collocated client+osd can theoretically cause problems when you run 
out of memory, but it doesn't sound like that's the case here.

> Can you help me to resolve this issue?

I assume the OSDs and MDS are all still running?

We fixed a number of bugs recently with multiple clients interacting with 
the same files.  Is the hang reproducable?  Can you try it with the latest 
unstable client and servers?  Or, enable mds debug logging and post that 
somewhere (debug mds = 20, debug ms = 1)?

Thanks-
sage

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
