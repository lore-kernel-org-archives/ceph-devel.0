From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: v12.1.2 Luminous (RC) released
Date: Wed, 02 Aug 2017 17:28:52 +0200
Message-ID: <87vam69eff.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53218 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdHBP2z (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 2 Aug 2017 11:28:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the third release candidate for Luminous, the next long term stable
release. Please note that this is still a *release candidate* and not
the final release, and hence not yet recommended on production clusters,
testing is welcome & we would love feedback and bug reports.

Ceph Luminous (v12.2.0) will be the foundation for the next long-term
stable release series.  There have been major changes since Kraken
(v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
Please read these release notes carefully,
http://ceph.com/releases/v12-1-2-luminous-rc-released/


Notable Changes since v12.1.0 (RC1)
-----------------------------------

* choose_args encoding has been changed to make it architecture-independent.
  If you deployed Luminous dev releases or 12.1.0 rc release and made use of
  the CRUSH choose_args feature, you need to remove all choose_args mappings
  from your CRUSH map before starting the upgrade.

* The 'ceph health' structured output (JSON or XML) no longer contains
  a 'timechecks' section describing the time sync status.  This
  information is now available via the 'ceph time-sync-status'
  command.

* Certain extra fields in the 'ceph health' structured output that
  used to appear if the mons were low on disk space (which duplicated
  the information in the normal health warning messages) are now gone.

* The "ceph -w" output no longer contains audit log entries by default.
  Add a "--watch-channel=audit" or "--watch-channel=*" to see them.

* The 'apply' mode of cephfs-journal-tool has been removed

* Added new configuration "public bind addr" to support dynamic environments
  like Kubernetes. When set the Ceph MON daemon could bind locally to an IP
  address and advertise a different IP address "public addr" on the network.

* New "ceph -w" behavior - the "ceph -w" output no longer contains I/O rates,
  available space, pg info, etc. because these are no longer logged to the
  central log (which is what "ceph -w" shows). The same information can be
  obtained by running "ceph pg stat"; alternatively, I/O rates per pool can
  be determined using "ceph osd pool stats". Although these commands do not
  self-update like "ceph -w" did, they do have the ability to return formatted
  output by providing a "--format=<format>" option.

* Pools are now expected to be associated with the application using them.
  Upon completing the upgrade to Luminous, the cluster will attempt to associate
  existing pools to known applications (i.e. CephFS, RBD, and RGW). In-use pools
  that are not associated to an application will generate a health warning. Any
  unassociated pools can be manually associated using the new
  "ceph osd pool application enable" command. For more details see
  "Associate Pool to Application" in the documentation.

* ceph-mgr now has a Zabbix plugin. Using zabbix_sender it sends trapper
  events to a Zabbix server containing high-level information of the Ceph
  cluster. This makes it easy to monitor a Ceph cluster's status and send
  out notifications in case of a malfunction.

* The 'mon_warn_osd_usage_min_max_delta' config option has been
  removed and the associated health warning has been disabled because
  it does not address clusters undergoing recovery or CRUSH rules that do
  not target all devices in the cluster.

* Specifying user authorization capabilities for RBD clients has been
  simplified. The general syntax for using RBD capability profiles is
  "mon 'profile rbd' osd 'profile rbd[-read-only][ pool={pool-name}[, ...]]'".
  For more details see "User Management" in the documentation.

* ``ceph config-key put`` has been deprecated in favor of ``ceph config-key set``.


Notable Changes since v12.1.1 (RC2)
-----------------------------------

* New "ceph -w" behavior - the "ceph -w" output no longer contains I/O rates,
  available space, pg info, etc. because these are no longer logged to the
  central log (which is what "ceph -w" shows). The same information can be
  obtained by running "ceph pg stat"; alternatively, I/O rates per pool can
  be determined using "ceph osd pool stats". Although these commands do not
  self-update like "ceph -w" did, they do have the ability to return formatted
  output by providing a "--format=<format>" option.

* Pools are now expected to be associated with the application using them.
  Upon completing the upgrade to Luminous, the cluster will attempt to associate
  existing pools to known applications (i.e. CephFS, RBD, and RGW). In-use pools
  that are not associated to an application will generate a health warning. Any
  unassociated pools can be manually associated using the new
  "ceph osd pool application enable" command. For more details see
  "Associate Pool to Application" in the documentation.

* ceph-mgr now has a Zabbix plugin. Using zabbix_sender it sends trapper
  events to a Zabbix server containing high-level information of the Ceph
  cluster. This makes it easy to monitor a Ceph cluster's status and send
  out notifications in case of a malfunction.

* The 'mon_warn_osd_usage_min_max_delta' config option has been
  removed and the associated health warning has been disabled because
  it does not address clusters undergoing recovery or CRUSH rules that do
  not target all devices in the cluster.

* Specifying user authorization capabilities for RBD clients has been
  simplified. The general syntax for using RBD capability profiles is
  "mon 'profile rbd' osd 'profile rbd[-read-only][ pool={pool-name}[, ...]]'".
  For more details see "User Management" in the documentation.

* RGW: bucket index resharding now uses the reshard  namespace in log pool
  upgrade scenarios as well this is a changed behaviour from RC1 where a
  new pool for reshard was created

* RGW multisite now supports for enabling or disabling sync at a bucket level.

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.1.2.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release sha1: b661348f156f148d764b998b65b90451f096cb27

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
