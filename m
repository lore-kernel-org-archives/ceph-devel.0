From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: osd activation under 9.1.0
Date: Fri, 16 Oct 2015 21:56:28 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9192524D89@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192524D2B@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510161434400.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0085.outbound.protection.outlook.com ([65.55.169.85]:48800
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751103AbbJPV4e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 17:56:34 -0400
In-Reply-To: <alpine.DEB.2.00.1510161434400.16833@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Friday, October 16, 2015 4:35 PM
> To: Deneau, Tom
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: osd activation under 9.1.0
> 
> On Fri, 16 Oct 2015, Deneau, Tom wrote:
> > Using 9.1.0 I am getting the error shown below at ceph-deploy osd
> activate time.
> >
> > + ceph-deploy --overwrite-conf osd activate Intel-2P-Sandy-Bridge-
> 04:/var/local//dev/sdf2:/dev/sdf1
> > ...
> > [][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph-osd --cluster
> ceph --mkfs --mkkey -i 4 --monmap /var/local/\
> > /dev/sdf2/activate.monmap --osd-data /var/local//dev/sdf2 --osd-journal
> /var/local//dev/sdf2/journal --osd-uuid 204865df-8dbf-4f26-91f2-
> 5dfa7c3a49f8 --keyring /var/local//dev/sdf2/keyring --setuser ceph --
> setgroup ceph
> > [][WARNIN] 2015-10-16 13:13:41.464615 7f3f40642940 -1
> filestore(/var/local//dev/sdf2) mkjournal error creating journ\
> > al on /var/local//dev/sdf2/journal: (13) Permission denied
> > [][WARNIN] 2015-10-16 13:13:41.464635 7f3f40642940 -1 OSD::mkfs:
> ObjectStore::mkfs failed with error -13
> > [][WARNIN] 2015-10-16 13:13:41.464669 7f3f40642940 -1  ** ERROR: error
> creating empty object store in /var/local//de\
> > v/sdf2: (13) Permission denied
> > [][WARNIN] Traceback (most recent call last):
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 3576, in <module>
> > [][WARNIN]     main(sys.argv[1:])
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 3530, in main
> > [][WARNIN]     args.func(args)
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 2432, in main_activate
> > [][WARNIN]     init=args.mark_init,
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 2258, in activate_dir
> > [][WARNIN]     (osd_id, cluster) = activate(path, activate_key_template,
> init)
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 2360, in activate
> > [][WARNIN]     keyring=keyring,
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 1950, in mkfs
> > [][WARNIN]     '--setgroup', get_ceph_user(),
> > [][WARNIN]   File "/usr/sbin/ceph-disk", line 349, in command_check_call
> > [][WARNIN]     return subprocess.check_call(arguments)
> > [][WARNIN]   File "/usr/lib/python2.7/subprocess.py", line 540, in
> check_call
> > [][WARNIN]     raise CalledProcessError(retcode, cmd)
> > [][WARNIN] subprocess.CalledProcessError: Command '['/usr/bin/ceph-osd',
> '--cluster', 'ceph', '--mkfs', '--mkkey', '
> > -i', '4', '--monmap', '/var/local//dev/sdf2/activate.monmap', '--osd-
> data', '/var/local//dev/sdf2', '--osd-journal',
> '/var/local//dev/sdf2/journal', '--osd-uuid', '204865df-8dbf-4f26-91f2-
> 5dfa7c3a49f8', '--keyring', '/var/local//dev/sdf2/keyring', '--setuser',
> 'ceph', '--setgroup\
> > ', 'ceph']' returned non-zero exit status 1
> > [][ERROR ] RuntimeError: command returned non-zero exit status: 1
> > [ceph_deploy][ERROR ] RuntimeError: Failed to execute command: ceph-disk
> -v activate --mark-init upstart --mount /var/local//dev/sdf2
> >
> > When I look at the data disk, I see the following.
> >
> >   -rw-r--r-- 1 root ceph   210 Oct 16 13:13 activate.monmap
> >   -rw-r--r-- 1 ceph ceph    37 Oct 16 13:13 ceph_fsid
> >   drwxr-sr-x 3 ceph ceph  4096 Oct 16 13:13 current
> >   -rw-r--r-- 1 ceph ceph    37 Oct 16 13:13 fsid
> >   lrwxrwxrwx 1 root ceph     9 Oct 16 13:13 journal -> /dev/sdf1
> 
> My guess is that /dev/sdf1 needs to be chowned to user ceph.
> 
> sage
> 

Yes, that seemed to do the trick
I had done that chown with the data mount point /var/local/dev/sdf2
but had not done it with the journal partition.

-- Tom

> 
> >   -rw-r--r-- 1 ceph ceph    21 Oct 16 13:13 magic
> >   -rw-r--r-- 1 ceph ceph     4 Oct 16 13:13 store_version
> >   -rw-r--r-- 1 ceph ceph    53 Oct 16 13:13 superblock
> >   -rw-r--r-- 1 ceph ceph     2 Oct 16 13:13 whoami
> >
> > (The parent directory has
> >   drwxr-sr-x 3 ceph ceph  4096 Oct 16 13:13 sdf2)
> >
> > I had been creating the partitions myself and then passing them to ceph-
> deploy osd prepare and osd activate.
> > Which worked fine before 9.1.0.
> > Is there some extra permissions setup I need to do for 9.1.0?
> >
> > Alternatively, is there a single-node setup script for 9.1.0 that I can
> look at?
> >
> > -- Tom Deneau
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
