From: Kevan Rehm <krehm@cray.com>
Subject: problems using calamari vagrant/devmode VM
Date: Tue, 17 May 2016 14:04:52 +0000
Message-ID: <D3608F32.A7176%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa1.cray.iphmx.com ([68.232.142.33]:5908 "EHLO
	esa1.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcEQOP4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 10:15:56 -0400
Content-Language: en-US
Content-ID: <A8D356AA1284A14EB1F6570995747EE9@namprd11.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Greetings,

Sorry for the newbie questions.   I followed the directions on page
http://calamari.readthedocs.io/en/latest/development/dev_env.html
to set up a calamari development environment, but was unsuccessful.  Co=
uld
someone help?

When executing the "vagrant up" command, the install_salt.sh script in =
the
VM failed with:

=8A
=3D=3D> default: Reading package lists...
=3D=3D> default: Building dependency tree...
=3D=3D> default: E
=3D=3D> default: :=20

=3D=3D> default: Unable to locate package git-core
=3D=3D> default:  * ERROR: Failed to run install_ubuntu_git_deps()!!!
The SSH command responded with a non-zero exit status. Vagrant
assumes that this means the command failed. The output for this command
should be in the log above. Please read the output to determine what
went wrong.


Apparently git is missing in the VM.  I ssh'd into the VM and installed
git, then re-ran the script as root, and it seemed to complete
successfully.    The instructions next say:

The result will be a virtual machine that you can connect to using vagr=
ant
ssh, containing a git clone of Calamari with a fully populated virtuale=
nv.
Activate the virtualenv contained in the env directory.

I see the /calamari.git directory, but where is the 'env' directory tha=
t
contains the virtualenv?   Did did the install_salt.sh script not reall=
y
work?

Also, the web page goes on to refer the reader to a screencast of the
process, but the link is broken, the account which posted the link has
been closed.   A replacement video would be nice.

=46inally, on https://github.com/ceph/calamari I followed the
http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com link  in orde=
r
to post this email, but the ceph-calamari@lists.ceph.com email address
posted there is for an mail list that has been discontinued.  Which
explains why in the archives that no-one responded to the U.S. Ambassad=
or
to Nigeria.  :-)   But some people still seem to be able to post there,
not sure how that is possible.  Could someone update the web page to po=
int
to ceph-devel instead?

Thanks, Kevan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
