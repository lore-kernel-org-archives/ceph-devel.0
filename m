From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: librgw init failed (-5)
Date: Mon, 10 Oct 2016 09:53:43 -0400 (EDT)
Message-ID: <1368180094.4143928.1476107623758.JavaMail.zimbra@redhat.com>
References: <7C82F41C-1C24-4D78-B79B-E7B3BE012FE7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:54198 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcJJNxq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 09:53:46 -0400
In-Reply-To: <7C82F41C-1C24-4D78-B79B-E7B3BE012FE7@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yiming xie <platoxym@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Yiming,

Can you share the contents of the RGW and FSAL blocks of your ganesha.conf?

For comparison, here's one that I use (keys sanitized):

"""
EXPORT
{
	# Export Id (mandatory, each EXPORT must have a unique Export_Id)
	Export_Id = 77;

	# Exported path (mandatory)
	Path = "/";

	# Pseudo Path (required for NFS v4)
	Pseudo = "/";

	# Required for access (default is None)
	# Could use CLIENT blocks instead
	Access_Type = RW;

	SecType = "sys";

	Protocols = 3,4;

	#Delegations = Readwrite;

	Squash = No_Root_Squash;

	# Exporting FSAL
	FSAL {
		Name = RGW;
		User_Id = "testuser";
		Access_Key_Id = "acckey";
		Secret_Access_Key = "secretkey";
	}
}

RGW {
    ceph_conf = "/opt/ceph-rgw/etc/ceph/ceph.conf";
    init_args = "-d --debug-rgw=16";
}

NFS_Core_Param
{
        Nb_Worker = 12;
}

NFSV4 {
    Graceless = true;
    Allow_Numeric_Owners = true;
    Only_Numeric_Owners = true;
}

LOG {
	# Default_Log_Level is unknown token??
	#Default_Log_Level = NIV_FULL_DEBUG;
	Components {
		#ALL = FULL_DEBUG;
		MEMLEAKS = FATAL;
		FSAL = FULL_DEBUG;
		NFSPROTO = FATAL;
		NFS_V4 = FATAL;
		EXPORT = FATAL;
		FILEHANDLE = FATAL;
		DISPATCH = FATAL;
		CACHE_INODE = FATAL;
		CACHE_INODE_LRU = FATAL;
		HASHTABLE = FATAL;
		HASHTABLE_CACHE = FATAL;
		DUPREQ = FATAL;
		INIT = DEBUG;
		MAIN = DEBUG;
		IDMAPPER = FATAL;
		NFS_READDIR = FATAL;
		NFS_V4_LOCK = FATAL;
		CONFIG = FATAL;
		CLIENTID = FATAL;
		SESSIONS = FATAL;
		PNFS = FATAL;
		RW_LOCK = FATAL;
		NLM = FATAL;
		RPC = FATAL;
		NFS_CB = FATAL;
		THREAD = FATAL;
		NFS_V4_ACL = FATAL;
		STATE = FATAL;
#		9P = FATAL;
#		9P_DISPATCH = FATAL;
		FSAL_UP = FATAL;
		DBUS = FATAL;
	}
	Facility {
		name = FILE;
		destination = "/tmp/ganesha-rgw.log";
		enable = active;
	}
}
"""

Regards,

Matt

----- Original Message -----
> From: "yiming xie" <platoxym@gmail.com>
> To: ceph-devel@vger.kernel.org
> Cc: "Matt Benjamin" <mbenjamin@redhat.com>
> Sent: Saturday, October 8, 2016 3:23:31 AM
> Subject: librgw init failed (-5)
> 
> I start nfs-ganesha with FSAL_RGW failed, the nfs-ganesha log is:
> "create_export :FSAL :CRIT :RGW module: librgw init failed (-5)”
> 
> ceph/src/rgw/librgw.cc:
> int librgw_create(librgw_t* rgw, int argc, char **argv)
> this interface return value equal -5 and it’s parameters as below:
> 
> argc=2
> argv[0] = “nfs-ganesha”
> argv[1] = “--conf=/etc/ceph/ceph.conf”
> 
> env:
> nfs-genahsa(2.3)
> librgw.so.2.0.0

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
H
