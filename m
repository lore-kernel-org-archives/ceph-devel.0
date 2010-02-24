From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Thu, 25 Feb 2010 00:21:53 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A3B58D6@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
	<a37615151002231011i33a905c8qa338c4018752cc9e@mail.gmail.com>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002240654191.1887@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5605@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002241039500.17054@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002241039500.17054@cobra.newdream.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

That's right the file was corrupted. Currently I have extremely slow network. So probably I'll open access to the non-corrupted file tomorrow. 
Meanwhile the system with higher trace level also hangs and I'll be able to send you more informative traces. 

Thanks,
Roman

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Wednesday, February 24, 2010 8:44 PM
To: Talyansky, Roman
Cc: ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck

Hi Roman,

On Wed, 24 Feb 2010, Talyansky, Roman wrote:
> Hi Sage,
> 
> Besides the bug with the return value of write operation, the system hangs in a write operation.
> You can access the trace files of ceph servers at 
> https://sapmats-de.sap-ag.de/download/download.cgi?id=DHTK24DYMIH8MJEYGMO5GT1GKDLBR9IJDKFAA3R0C4D1JGTYVW

The .tar.gz appears to be corrupt (gunzip complains)... :(

> The traces were collected without "debug mds = 20" in the configuration 
> file. I still have the hang system available. I also run the systems to 
> regenerate the hang with "debug mds = 20" defined.
> 
> It would be great if we could have a chat to resolve the hang in about 4 
> hours.

Sounds good.  We should just be back from lunch, and will be in #ceph on 
irc.oftc.net, or on jabber!

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
