From: Sage Weil <sage@newdream.net>
Subject: Re: Problem on ceph configuration
Date: Thu, 14 Jan 2010 08:45:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1001140840180.629@cobra.newdream.net>
References: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
	<8C507B5E0BA5114E933C3C6E2E9729E005ECB4211B@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8C507B5E0BA5114E933C3C6E2E9729E005ECB4211B@DEWDFECCR01.wdf.sap.corp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "Magarshak, Roman" <roman.magarshak@sap.com>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>, "Talyansky, Roman" <roman.talyansky@sap.com>
List-Id: ceph-devel.vger.kernel.org

Hi Roman,

On Thu, 14 Jan 2010, Magarshak, Roman wrote:
> Hi all ,
>   I've forgot to mention that the problems is , that the kernel client 
> gets stuck and any other mount tries fail.

From the log, it looks like the MDS has responded to the requests it 
received.  I don't see any 'touch' in there, though, only a (successful) 
readdir.  Can you 'mount -t debugfs /sys/kernel/debug' (if not already 
mounted) and look at /sys/kernel/debug/ceph/*/mdsc to see which MDS 
request is hanging?  That, combined with the MDS log, will provide more 
information about what exactly is hanging.

Also, can you describe the exact command sequence that caused the hang?

Thanks!
sage


 >  
> 
> \Roman.
> 
> 
> Roman Magarshak
> Intern
> SAP Research Israel
> T   +972   9 777 9853
> M  +972 54 464 0910
> E   mailto:roman.magarshak@sap.com
> 
> From: Magarshak, Roman [mailto:roman.magarshak@sap.com]
> Sent: Thursday, January 14, 2010 5:25 PM
> To: ceph-devel@lists.sourceforge.net
> Cc: Talyansky, Roman
> Subject: [LIKELY JUNK][ceph-devel] Problem on ceph configuration
> 
> Hi all ,
>   We have tried to run ceph on 2 nodes without btrfs and encountered the following problem?
> 
> The system:
> 2 Virtual (on vmware) 32 bit machines , running Debian Lenny  unstable
> Both have access to NFS (where the configuration file is kept)
> 
> Kernel version:  2.6.32-trunk-vserver-686
> Ceph is installed from tar.gz including kernel and fuse clients (version 0.18)
> Ceph1=10.26.236.93
> Ceph2=10.26.236.94
> On both servers /ceph /ceph/out /ceph/log exists.
> 
> The scenario:
> 
> On ceph1 the following commands are executed:
> $ mkcephfs --allhosts -c /mnt/nfs/ceph/ceph.conf
> $ /etc/init.d/ceph -a -c /mnt/nfs/ceph/ceph.conf start
> 
> After that the cmds , cmon, cosd are running
> 
> Now the following commands on ceph2 are executed:
> $ mount -t ceph ceph1:6789:/ /mnt/ceph
> The mount succeeds
> After 'ls' and 'touch' commands, the console gets stuck.
> Dmesg log  is attached.
> 
> On ceph1 cmds no longer appears on ps.
> 
> Ceph2 console gets stuck, and umount is no longer possible.
> Mds logs, configuration files and dmesg logs are attached.
> 
> 
> Has anyone encountered a similar problem?
> 
> 
> Thank you in advance for your help.
> \Roman
> Roman Magarshak
> Intern
> SAP Research Israel
> T   +972   9 777 9853
> M  +972 54 464 0910
> E   mailto:roman.magarshak@sap.com
> 
> 

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
