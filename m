From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Bug#506040: Status of ceph ITP?
Date: Tue, 30 Nov 2010 01:00:13 +0100
Message-ID: <1291075213.14018.101.camel@julia.gcs.org.hu>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
Reply-To: Laszlo Boszormenyi <gcs@debian.hu>, 506040@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.506040.B506040.12910752495988@bugs.debian.org>
In-Reply-To: <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Sage Weil <sage@newdream.net>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi all,

On Mon, 2010-11-29 at 11:24 -0800, Sage Weil wrote:
> On Mon, 22 Nov 2010, Clint Byrum wrote:
> > Yes we'd much rather have a single package that works in both Debian and
> > Ubuntu.
 That would be an important goal. Feel free to contact me if you need
any changes to be more suitable for Ubuntu.

> > If you know exactly what package is being looked at for upload into
> > Debian, I can at least start with that so that the merge when it finally
> > does get uploaded is much simpler.
 You can get the modified package from my site[1]. I don't say it's
ready, but fixes most of the problems that Sage made.

> As I understand it, the current issues are:
>  - whitespace in debian/rules
 Yes, there was some extra whitespace, an extra and missing blank lines
in debian/rules . It's cosmetic only of course.

>  - something with the .install files and installing into the source tree 
> that I didn't understand.. can you clarify Laszlo?
 Sure. The biggest problem was that you installed everything to
$(CURDIR) , which is the source tree. Then you used dh_install to move
out the files from there. make install was a bit nonsense this way, as
the compiled binaries was already in the source tree; there was no need
to install them the same place. I've changed it to the more common
$(DESTDIR) which is debian/tmp/ . This way you can use --list-missing or
the more aggressive --fail-missing to dh_install to see if you miss
files.
Yes, you do missed files. One is the radosacl binary, that I put into
the radosgw package. You neither installed
usr/share/ceph_tool/gui_resources/ (SVG and glade files) that went into
the ceph package.
Your cleaning process missed several points like the missing removal of
src/.deps/ and some generated files. There are more you can find.

I've changed the way debug parts of the packages are handled. It may
sound harsh and so I'm open to revert that back to your way.

Less important mistakes that debian/changes is for packaging changes,
for upstream changes you can use ChangeLog ; it can be installed with
dh_installdocs .
Also implicitly noted that this is a first generation package (not
converted to quilt as Sage said it should build on Lenny as well).

Sage: may you let me handle the packaging for Debian and Ubuntu? So you
can find more time working on ceph itself as it has some inconsistency
as well. Binaries without manpages like cephfs and radosacl ; somewhere
the manpage contains an example which is not a valid command (at least
in v0.23 , it passed midnight and now I can't remember which one is it).

Are you sure that ceph should depend on hdparm? What if my box has SCSI,
SAS or other disk that isn't [sP]ATA? Yes, there's sdparm, but do you
use it directly from ceph? Should it be a recommendation instead?
Also uniformed *.install files, don't start them with a slash.
Added a watch file and specific fields to debian/control .

If others agree, I'll upload it in some days. It'll sit into the NEW
queue and may take a while to be officially accepted.

Regards,
Laszlo/GCS
[1] dget http://www.routers.hu/gcs/ceph_0.23.1-1.dsc
