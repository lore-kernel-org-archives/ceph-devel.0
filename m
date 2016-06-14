From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: ceph-disk permissions errors when using dmcrypt/plain keys
Date: Tue, 14 Jun 2016 12:09:52 -0400
Message-ID: <CAGbvivKYhPs1AswoumRwf2ZyEXN0aeZnBThdbJihHNhpGWAuSA@mail.gmail.com>
References: <CAGbvivLErxQW8EkXvwNN9WAiasxsOM5YQL+MqxtaHpRPxRxA1Q@mail.gmail.com>
	<57601A7E.3030600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38450 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbcFNQJx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 12:09:53 -0400
Received: by mail-it0-f43.google.com with SMTP id h190so70412063ith.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2016 09:09:53 -0700 (PDT)
In-Reply-To: <57601A7E.3030600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

In this particular case, we are using the same disk for both data and
journal, and both are encrypted with dmcrypt using the "plain" keys
(not luks).

Options of interest:

setuser match path=/var/lib/ceph/$type/$cluster-$id
osd objectstore = filestore
osd_dmcrypt_type = plain

$ sudo /sbin/parted -s /dev/sdc mklabel gpt
$ sudo  /usr/sbin/ceph-disk -v prepare --fs-type xfs --cluster ceph
--dmcrypt -- /dev/sdc
-- no error reported

$ sudo /usr/sbin/ceph-disk -v --setuser ceph --setgroup ceph activate-all

activate: Cluster name is ceph
activate: OSD uuid is a4e61724-61f0-43e0-bf33-be56ce85fc8c
activate: OSD id is 0
activate: Initializing OSD...
command_check_call: Running command: /usr/bin/ceph --cluster ceph
--name client.bootstrap-osd --keyring
/var/lib/ceph/bootstrap-osd/ceph.keyring mon getmap -o
/var/lib/ceph/tmp/mnt.N43luZ/activate.monmap
got monmap epoch 1
command_check_call: Running command: /usr/bin/ceph-osd --cluster ceph
--mkfs --mkkey -i 0 --monmap
/var/lib/ceph/tmp/mnt.N43luZ/activate.monmap --osd-data
/var/lib/ceph/tmp/mnt.N43luZ --osd-journal
/var/lib/ceph/tmp/mnt.N43luZ/journal --osd-uuid
a4e61724-61f0-43e0-bf33-be56ce85fc8c --keyring
/var/lib/ceph/tmp/mnt.N43luZ/keyring --setuser ceph --setgroup ceph
unable to stat setuser_match_path /var/lib/ceph/$type/$cluster-$id:
(2) No such file or directory
mount_activate: Failed to activate
unmount: Unmounting /var/lib/ceph/tmp/mnt.N43luZ
command_check_call: Running command: /bin/umount -- /var/lib/ceph/tmp/mnt.N43luZ
ceph-disk: Command '['/usr/bin/ceph-osd', '--cluster', 'ceph',
'--mkfs', '--mkkey', '-i', '0', '--monmap',
'/var/lib/ceph/tmp/mnt.N43luZ/activate.monmap', '--osd-data',
'/var/lib/ceph/tmp/mnt.N43luZ', '--osd-journal',
'/var/lib/ceph/tmp/mnt.N43luZ/journal', '--osd-uuid',
'a4e61724-61f0-43e0-bf33-be56ce85fc8c', '--keyring',
'/var/lib/ceph/tmp/mnt.N43luZ/keyring', '--setuser', 'ceph',
'--setgroup', 'ceph']' returned non-zero exit status 1
Traceback (most recent call last):
  File "/usr/sbin/ceph-disk", line 9, in <module>
    load_entry_point('ceph-disk==1.0.0', 'console_scripts', 'ceph-disk')()
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4964, in run
    main(sys.argv[1:])
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line 4915, in main
    args.func(args)
  File "/usr/lib/python2.7/dist-packages/ceph_disk/main.py", line
3755, in main_activate_all
    raise Error('One or more partitions failed to activate')
ceph_disk.main.Error: Error: One or more partitions failed to activate



However, If I remove the "setuser match
path=/var/lib/ceph/$type/$cluster-$id" option, it appears to prepare
the disk successfully:
$ sudo /sbin/parted -s /dev/sdc mklabel gpt
$ sudo  /usr/sbin/ceph-disk -v prepare --fs-type xfs --cluster ceph
--dmcrypt -- /dev/sdc
-- no error reported

ceph-osd process starts and appears to be working.










On Tue, Jun 14, 2016 at 10:53 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Could you please detail the steps to reproduce the problem ? There are tests verifying it works on ubuntu 14.04.4 but there apparently is a use case missing.
>
> Thanks for your help :-)
>
