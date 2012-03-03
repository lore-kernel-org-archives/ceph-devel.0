From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 1/3] java: add Java and C++ source files
Date: Fri, 02 Mar 2012 16:48:53 -0800
Message-ID: <4F516A75.6020500@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37143 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2CCAtG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 19:49:06 -0500
Received: from martini.local (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 82FED1008A88
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 16:49:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This adds all of the Java and C++ source files that make up the
libcephfs Java wrappers package.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/java/README                                    |   43 +
 src/java/build.xml                                 |   67 ++
 .../java/net/newdream/ceph/fs/CephConstants.java   |   38 +
 .../java/net/newdream/ceph/fs/CephDirectory.java   |   84 ++
 .../java/net/newdream/ceph/fs/CephException.java   |   21 +
 .../ceph/fs/CephInvalidStateException.java         |   11 +
 src/java/java/net/newdream/ceph/fs/CephMount.java  |  360 +++++++
 .../net/newdream/ceph/fs/CephNativeLoader.java     |   16 +
 src/java/java/net/newdream/ceph/fs/CephProxy.java  |  217 ++++
 src/java/java/net/newdream/ceph/fs/CephStat.java   |   15 +
 .../java/net/newdream/ceph/fs/CephStatVFS.java     |   14 +
 src/java/java/net/newdream/ceph/fs/CephStruct.java |   33 +
 src/java/native/libcephfs_jni.cc                   | 1037 ++++++++++++++++++++
 src/java/test/CephMountCreateTest.java             |   76 ++
 src/java/test/CephMountTest.java                   |   72 ++
 15 files changed, 2104 insertions(+), 0 deletions(-)
 create mode 100644 src/java/README
 create mode 100644 src/java/build.xml
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephConstants.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephDirectory.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephException.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephMount.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephNativeLoader.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephProxy.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStat.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStatVFS.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStruct.java
 create mode 100644 src/java/native/libcephfs_jni.cc
 create mode 100644 src/java/test/CephMountCreateTest.java
 create mode 100644 src/java/test/CephMountTest.java

diff --git a/src/java/README b/src/java/README
new file mode 100644
index 0000000..540425d
--- /dev/null
+++ b/src/java/README
@@ -0,0 +1,43 @@
+libcephfs Java wrappers
+=======================
+
+- native/: C++
+- java/: Java
+- test/: JUnit tests
+- lib/: JUnit library
+- build.xml: Test runner
+
+Building
+--------
+
+Autotools handles the build using the configure flag --enable-cephfs-java
+
+Testing
+-------
+
+Testing depends on JUnit. To run the tests make sure that the JUnit JAR is
+available in the lib/ directory. For example:
+
+  $ mkdir lib
+  $ cd lib
+  $ curl -O https://github.com/downloads/KentBeck/junit/junit-4.8.2.jar
+
+Ant is used to run the unit tests:
+
+  $ ant test
+
+1. The tests depend on the compiled wrappers. If the wrappers are installed as
+part of a package (e.g. Debian package) then this should 'just work'. Ant will
+also look in the current directory for 'libcephfs.jar' and in ../.libs for the
+JNI library.  If all else fails, set the environment variables CEPHFS_JAR, and
+CEPHFS_JNI_LIB accordingly.
+
+2. Set CEPHFS_CONF environment variable to point to a ceph.conf. This can be
+ommitted if the desired configuration file can be found in a default location.
+
+Documentation
+-------------
+
+Ant is used to build the Javadocs:
+
+  $ ant docs
diff --git a/src/java/build.xml b/src/java/build.xml
new file mode 100644
index 0000000..f846ca4
--- /dev/null
+++ b/src/java/build.xml
@@ -0,0 +1,67 @@
+<?xml version="1.0"?>
+<project name="cephfs-java" default="main" basedir=".">
+
+    <description>CephFS Java Bindings</description>
+
+	<property name="src.dir" location="java" />
+	<property name="doc.dir" location="doc" />
+    <property name="lib.dir" location="lib" />
+	<property name="test.src.dir" location="test" />
+    <property name="test.build.dir" location="test_build" />
+
+    <property environment="env"/>
+
+	<target name="clean">
+		<delete dir="${doc.dir}" />
+		<delete dir="${test.build.dir}" />
+	</target>
+
+	<target name="makedir">
+		<mkdir dir="${doc.dir}" />
+		<mkdir dir="${test.build.dir}" />
+	</target>
+
+	<target name="docs" depends="makedir">
+		<javadoc packagenames="src" sourcepath="${src.dir}" destdir="${doc.dir}">
+			<fileset dir="${src.dir}">
+                <include name="**/*.java" />
+			</fileset>
+		</javadoc>
+	</target>
+
+	<target name="compile-tests" depends="makedir">
+        <javac srcdir="${test.src.dir}" destdir="${test.build.dir}"
+            includeantruntime="false">
+            <classpath>
+				<pathelement location="${env.CEPHFS_JAR}"/>
+				<pathelement location="libcephfs.jar"/>
+                <fileset dir="${lib.dir}">
+                    <include name="**/*.jar"/>
+                </fileset>
+            </classpath>
+		</javac>
+	</target>
+
+	<target name="test" depends="compile-tests">
+        <junit printsummary="yes" haltonfailure="yes" showoutput="yes">
+			<sysproperty key="java.library.path" path="${env.CEPHFS_JNI_LIB}:../.libs/"/>
+            <sysproperty key="CEPH_CONF_FILE" path="${env.CEPHFS_CONF}"/>
+            <classpath>
+                <fileset dir="${lib.dir}">
+                    <include name="**/*.jar"/>
+                </fileset>
+				<pathelement location="${env.CEPHFS_JAR}"/>
+				<pathelement location="libcephfs.jar"/>
+                <pathelement path="${test.build.dir}"/>
+                <pathelement path="${test.src.dir}"/>
+            </classpath>
+            <formatter type="plain"/>
+            <batchtest fork="yes">
+                <fileset dir="${test.src.dir}">
+                    <include name="**/*Test.java"/>
+                </fileset>
+            </batchtest>
+        </junit>
+    </target>
+
+</project>
diff --git a/src/java/java/net/newdream/ceph/fs/CephConstants.java b/src/java/java/net/newdream/ceph/fs/CephConstants.java
new file mode 100644
index 0000000..5e4c5a7
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephConstants.java
@@ -0,0 +1,38 @@
+package net.newdream.ceph.fs;
+
+public class CephConstants {
+
+	/*
+	 * The constants here are initialized from JNI.
+	 */
+	static {
+		CephNativeLoader.checkLoaded();
+	}
+
+	/* lseek */
+	public static int SEEK_SET;
+	public static int SEEK_CUR;
+	public static int SEEK_END;
+
+	/* open */
+	public static int O_RDONLY;
+	public static int O_RDWR;
+	public static int O_APPEND;
+	public static int O_CREAT;
+	public static int O_TRUNC;
+	public static int O_EXCL;
+
+	/* setattr */
+	public static int SETATTR_MODE;
+	public static int SETATTR_UID;
+	public static int SETATTR_GID;
+	public static int SETATTR_MTIME;
+	public static int SETATTR_ATIME;
+
+	/* errno */
+	public static int EINVAL;
+	public static int ENOENT;
+	public static int EEXIST;
+	public static int ERANGE;
+	public static int ENAMETOOLONG;
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephDirectory.java b/src/java/java/net/newdream/ceph/fs/CephDirectory.java
new file mode 100644
index 0000000..fcf0b21
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephDirectory.java
@@ -0,0 +1,84 @@
+package net.newdream.ceph.fs;
+
+import java.lang.String;
+import java.util.Arrays;
+import java.util.ArrayList;
+
+/**
+ * Methods on directories.
+ */
+public class CephDirectory extends CephStruct<CephDirectory.State> {
+	private CephMount mount;
+
+	private long instance_ptr;
+	long c_ptr() { return instance_ptr; }
+	enum State { PREPARING, OPEN }
+
+	/**
+	 * Open a directory.
+	 *
+	 * @param mount The file system mount.
+	 * @param path Path to the directory.
+	 */
+	CephDirectory(CephMount mount, String path) throws CephException {
+		super(State.PREPARING);
+		this.mount = mount;
+		open(path);
+	}
+
+	/**
+	 * Open a directory.
+	 *
+	 * @param path Path to the directory.
+	 */
+	public int open(String path) throws CephException {
+		return mount.opendir(this, path);
+	}
+
+	/**
+	 * Close directory.
+	 */
+	public int close() throws CephException {
+		return mount.closedir(this);
+	}
+
+	/**
+	 * Read directory names.
+	 *
+	 * @param bufSize Low-level buffer size.
+	 */
+	public String[] getdnames(int bufSize) throws CephException {
+		ArrayList<String> dnames = new ArrayList<String>();
+		byte[] buf = new byte[bufSize];
+		int ret;
+
+		while (true) {
+			Arrays.fill(buf, (byte)0);
+			ret = mount.getdnames(this, buf, buf.length);
+			if (ret == -CephConstants.ERANGE) {
+				buf = new byte[buf.length*2];
+				continue;
+			}
+
+			if (ret <= 0)
+				break;
+
+			int pos = 0;
+			while (pos < ret) {
+				int len = 0;
+				while (buf[pos+len] != (byte)0) { len++; }
+				dnames.add(new String(buf, pos, len).trim());
+				pos += len + 1;
+			}
+		}
+
+		return dnames.toArray(new String[dnames.size()]);
+	}
+
+	/**
+	 * Read directory names.
+	 */
+	public String[] getdnames() throws CephException {
+		return getdnames(4096);
+	}
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephException.java b/src/java/java/net/newdream/ceph/fs/CephException.java
new file mode 100644
index 0000000..4af7bfe
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephException.java
@@ -0,0 +1,21 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Class that represents generic Ceph exception.
+ */
+public class CephException extends Exception {
+
+    /**
+     * Create basic CephException.
+     */
+    public CephException() {
+        super();
+    }
+
+    /**
+     * Create CephException with message.
+     */
+    public CephException(String s) {
+        super(s);
+    }
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java b/src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java
new file mode 100644
index 0000000..e995b09
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java
@@ -0,0 +1,11 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Represents invalid use of low-level Ceph pointers.
+ */
+public class CephInvalidStateException extends CephException {
+	
+	public CephInvalidStateException(String m) {
+		super(m);
+	}
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephMount.java b/src/java/java/net/newdream/ceph/fs/CephMount.java
new file mode 100644
index 0000000..65a55f6
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephMount.java
@@ -0,0 +1,360 @@
+package net.newdream.ceph.fs;
+
+import java.util.Arrays;
+import java.lang.String;
+
+/**
+ * Main entry point to libcephfs providing a one-to-one mapping
+ * with the libcephfs C library.
+ */
+public class CephMount extends CephStruct<CephMount.State> {
+	private long instance_ptr;
+	long c_ptr() { return instance_ptr; }
+	enum State { PREPARING, CONFIGURING, MOUNTED }
+
+	/**
+	 * Create a new CephMount instance.
+	 */
+	public CephMount() throws CephException {
+		this(null);
+	}
+
+	/**
+	 * Create a new CephMount instance with the given ID.
+	 *
+	 * @param id The ID.
+	 */
+	public CephMount(String id) throws CephException {
+		super(State.PREPARING);
+		CephProxy.ceph_create(this, id);
+	}
+
+	/**
+	 * Activate the mount. 
+	 */
+	public void mount() throws CephException {
+		mount(null);
+	}
+
+	/**
+	 * Activate the mount with a given root path.
+	 *
+	 * @param root The path to use as the root.
+	 */
+	public void mount(String root) throws CephException {
+		CephProxy.ceph_mount(this, root);
+	}
+
+	/**
+	 * Shutdown the mount.
+	 */
+	public void shutdown() throws CephException {
+		CephProxy.ceph_shutdown(this);
+	}
+
+	/**
+	 * Load configuration from a file.
+	 *
+	 * @param path The path to the configuration file.
+	 */
+	public void conf_read_file(String path) throws CephException {
+		CephProxy.ceph_conf_read_file(this, path);
+	}
+
+	/**
+	 * Load configuration from multiple files.
+	 *
+	 * @param paths A list of paths to configuration files.
+	 */
+	public void conf_read_files(String[] paths) throws CephException {
+		for (String path: paths) {
+			conf_read_file(path);
+		}
+	}
+
+	/**
+	 * Set a specific configuration option value.
+	 *
+	 * @param option The configuration option to modify.
+	 * @param value The new value of the option.
+	 */
+	public void conf_set(String option, String value) throws CephException {
+		CephProxy.ceph_conf_set(this, option, value);
+	}
+
+	/**
+	 * Get the value of a configuration option.
+	 *
+	 * @param option The name of the configuration option.
+	 * @param bufSize Size of internal buffer to use.
+	 * @return The value of the option or null if option not found
+	 */
+	public String conf_get(String option, int bufSize) throws CephException {
+		byte[] buf = new byte[bufSize];
+		int ret;
+		
+		while (true) {
+			Arrays.fill(buf, (byte)0);
+			ret = CephProxy.ceph_conf_get(this, option, buf, buf.length);
+			if (ret == -CephConstants.ENAMETOOLONG) {
+				buf = new byte[buf.length*2];
+				continue;
+			} else
+				break;
+		}
+
+		if (ret == 0)
+			return new String(buf).trim();
+		else if (ret == -CephConstants.ENOENT)
+			return null;
+		else
+			throw new CephException("unhandled return value: " + ret);
+	}
+
+	/**
+	 * Get the value of a configuration option.
+	 *
+	 * @param option The name of the configuration option.
+	 * @return The value of the option or null if option not found
+	 */
+	public String conf_get(String option) throws CephException {
+		return conf_get(option, 64);
+	}
+
+	/**
+	 * Get the current working directory.
+	 *
+	 * @return The current working directory in Ceph.
+	 */
+	public String getcwd() throws CephException {
+		return CephProxy.ceph_getcwd(this);
+	}
+
+	/**
+	 * Set the current working directory.
+	 *
+	 * @param path The directory set as the cwd.
+	 */
+	public void chdir(String path) throws CephException {
+		CephProxy.ceph_chdir(this, path);
+	}
+
+	/**
+	 * Create a directory and all parents.
+	 *
+	 * @param path The directory to create.
+	 * @param mode The mode of the new directory.
+	 */
+	public void mkdirs(String path, int mode) throws CephException {
+		CephProxy.ceph_mkdirs(this, path, mode);
+	}
+
+	/**
+	 * Delete a directory.
+	 *
+	 * @param path The directory to delete.
+	 */
+	public void rmdir(String path) throws CephException {
+		CephProxy.ceph_rmdir(this, path);
+	}
+
+	/**
+	 * Unlink/delete a name from the file system.
+	 *
+	 * @param path The name to unlink/delete.
+	 */
+	public void unlink(String path) throws CephException {
+		CephProxy.ceph_unlink(this, path);
+	}
+
+	/**
+	 * Rename the name of a file.
+	 *
+	 * @param from The current path.
+	 * @param to The new path.
+	 */
+	public void rename(String from, String to) throws CephException {
+		CephProxy.ceph_rename(this, from, to);
+	}
+
+	/**
+	 * Close an open file.
+	 *
+	 * @param fd The file descriptor.
+	 */
+	public void close(int fd) throws CephException {
+		CephProxy.ceph_close(this, fd);
+	}
+
+	/**
+	 * Read from a file.
+	 *
+	 * @param fd The file descriptor.
+	 * @param buf Buffer to for data read.
+	 * @param size Amount of data to read into the buffer.
+	 * @param offset Offset to read from (-1 for current position).
+	 */
+	public int read(int fd, byte[] buf, long size, long offset) throws CephException {
+		return CephProxy.ceph_read(this, fd, buf, size, offset);
+	}
+
+	/**
+	 * Write to a file.
+	 *
+	 * @param fd The file descriptor.
+	 * @param buf Buffer to write.
+	 * @param size Amount of data to write.
+	 * @param offset Offset to write from (-1 for current position).
+	 */
+	public int write(int fd, byte[] buf, long size, long offset) throws CephException {
+		return CephProxy.ceph_write(this, fd, buf, size, offset);
+	}
+
+	/**
+	 * Get the stripe unit of a file.
+	 *
+	 * @param fd The file descriptor.
+	 * @return The stripe unit.
+	 */
+	public int get_file_stripe_unit(int fd) throws CephException {
+		return CephProxy.ceph_get_file_stripe_unit(this, fd);
+	}
+
+	/**
+	 * Get the replication of a file.
+	 *
+	 * @param fd The file descriptor.
+	 * @return The file replication.
+	 */
+	public int get_file_replication(int fd) throws CephException {
+		return CephProxy.ceph_get_file_replication(this, fd);
+	}
+
+	/**
+	 * Set the default file stripe unit.
+	 *
+	 * @param stripe_unit The stripe unit.
+	 */
+	public void set_default_file_stripe_unit(int stripe_unit) throws CephException {
+		CephProxy.ceph_set_default_file_stripe_unit(this, stripe_unit);
+	}
+
+	/**
+	 * Set the default file stripe count.
+	 *
+	 * @param stripe_count The stripe count.
+	 */
+	public void set_default_file_stripe_count(int stripe_count) throws CephException {
+		CephProxy.ceph_set_default_file_stripe_count(this, stripe_count);
+	}
+
+	/**
+	 * Set the default object size.
+	 *
+	 * @param object_size The object size.
+	 */
+	public void set_default_object_size(int object_size) throws CephException {
+		CephProxy.ceph_set_default_object_size(this, object_size);
+	}
+
+	/**
+	 * Set the default file replication.
+	 *
+	 * @param replication Number of replicas.
+	 */
+	public void set_default_file_replication(int replication) throws CephException {
+		CephProxy.ceph_set_default_file_replication(this, replication);
+	}
+
+	/**
+	 * Seek to a position in a file.
+	 *
+	 * @param fd File descriptor.
+	 * @param offset New offset.
+	 * @param whence Whence value (see CephConstants.java).
+	 */
+	public long lseek(int fd, long offset, int whence) throws CephException {
+		return CephProxy.ceph_lseek(this, fd, offset, whence);
+	}
+
+	/**
+	 * Open a file.
+	 *
+	 * @param path Path of file to open or create.
+	 * @param flags Open flags (see CephConstants.java).
+	 * @param mode Permission mode.
+	 */
+	public int open(String path, int flags, int mode) throws CephException {
+		return CephProxy.ceph_open(this, path, flags, mode);
+	}
+
+	/**
+	 * Get file statistics.
+	 *
+	 * @param path Path of file to stat.
+	 * @param stat CephStat structure to hold results.
+	 */
+	public int lstat(String path, CephStat stat) throws CephException {
+		return CephProxy.ceph_lstat(this, path, stat);
+	}
+
+	/**
+	 * Set file attributes.
+	 *
+	 * @param relpath Path to file.
+	 * @param stat CephStat structure holding attributes.
+	 * @param mask Mask specifying which attributes to set.
+	 */
+	public int setattr(String relpath, CephStat stat, int mask) throws CephException {
+		return CephProxy.ceph_setattr(this, relpath, stat, mask);
+	}
+
+	/**
+	 * Get file system statistics.
+	 *
+	 * @param path Path to file in file system.
+	 * @param statvfs CephStatVFS structure to hold statistics.
+	 */
+	public int statfs(String path, CephStatVFS statvfs) throws CephException {
+		return CephProxy.ceph_statfs(this, path, statvfs);
+	}
+
+	/**
+	 * Open directory.
+	 *
+	 * @param path Path to directory.
+	 */
+	public CephDirectory opendir(String path) throws CephException {
+		return new CephDirectory(this, path);
+	}
+
+	/**
+	 * Open directory.
+	 *
+	 * @param dir CephDirectory structure representing directory.
+	 * @param path Path to directory.
+	 */
+	public int opendir(CephDirectory dir, String path) throws CephException {
+		return CephProxy.ceph_opendir(this, dir, path);
+	}
+
+	/**
+	 * Close directory.
+	 *
+	 * @param dir CephDirectory previously opened.
+	 */
+	public int closedir(CephDirectory dir) throws CephException {
+		return CephProxy.ceph_closedir(this, dir);
+	}
+
+	/**
+	 * Get directory names.
+	 *
+	 * @param dir CephDirectory previously opened.
+	 * @param buf Buffer for names.
+	 * @param len Amount of chars to read at once.
+	 */
+	public int getdnames(CephDirectory dir, byte[] buf, long len) throws CephException {
+		return CephProxy.ceph_getdnames(this, dir, buf, len);
+	}
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephNativeLoader.java b/src/java/java/net/newdream/ceph/fs/CephNativeLoader.java
new file mode 100644
index 0000000..5a681ca
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephNativeLoader.java
@@ -0,0 +1,16 @@
+package net.newdream.ceph.fs;
+
+class CephNativeLoader {
+
+	private static boolean loaded = false;
+
+	static {
+		if (!loaded) {
+			System.loadLibrary("cephfs_jni");
+			CephProxy.native_initialize();
+			loaded = true;
+		}
+	}
+
+	static void checkLoaded() { assert(loaded); }
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephProxy.java b/src/java/java/net/newdream/ceph/fs/CephProxy.java
new file mode 100644
index 0000000..02d0a49
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephProxy.java
@@ -0,0 +1,217 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Low-level access to JNI with basic sanity checks.
+ */
+class CephProxy {
+
+	static {
+		CephNativeLoader.checkLoaded();
+	}
+
+	static int ceph_create(CephMount mount, String root) throws CephException {
+		mount.requireState(CephMount.State.PREPARING);
+		int ret = native_ceph_create(mount, root);
+		if (ret == 0)
+			mount.setState(CephMount.State.CONFIGURING);
+		return ret;
+	}
+
+	static int ceph_mount(CephMount mount, String root) throws CephException {
+		mount.requireState(CephMount.State.CONFIGURING);
+		int ret = native_ceph_mount(mount.c_ptr(), root);
+		if (ret == 0)
+			mount.setState(CephMount.State.MOUNTED);
+		return ret;
+	}
+
+	static void ceph_shutdown(CephMount mount) throws CephException {
+		mount.requireState(CephMount.State.CONFIGURING, CephMount.State.MOUNTED);
+		native_ceph_shutdown(mount.c_ptr());
+	}
+
+	static int ceph_conf_set(CephMount mount, String option, String value) throws CephException {
+		mount.requireState(CephMount.State.CONFIGURING, CephMount.State.MOUNTED);
+		return native_ceph_conf_set(mount.c_ptr(), option, value);
+	}
+
+	static int ceph_conf_read_file(CephMount mount, String path) throws CephException {
+		mount.requireState(CephMount.State.CONFIGURING, CephMount.State.MOUNTED);
+		return native_ceph_conf_read_file(mount.c_ptr(), path);
+	}
+
+	static int ceph_conf_get(CephMount mount, String option, byte[] buf, long len) throws CephException {
+		mount.requireState(CephMount.State.CONFIGURING, CephMount.State.MOUNTED);
+		return native_ceph_conf_get(mount.c_ptr(), option, buf, len);
+	}
+
+	static String ceph_getcwd(CephMount mount) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_getcwd(mount.c_ptr());
+	}
+
+	static int ceph_chdir(CephMount mount, String dir) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_chdir(mount.c_ptr(), dir);
+	}
+
+	static int ceph_mkdirs(CephMount mount, String path, int mode) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_mkdirs(mount.c_ptr(), path, mode);
+	}
+
+	static int ceph_rmdir(CephMount mount, String path) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_rmdir(mount.c_ptr(), path);
+	}
+
+	static int ceph_unlink(CephMount mount, String path) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_unlink(mount.c_ptr(), path);
+	}
+
+	static int ceph_rename(CephMount mount, String from, String to) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_rename(mount.c_ptr(), from, to);
+	}
+
+	static int ceph_close(CephMount mount, int fd) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_close(mount.c_ptr(), fd);
+	}
+
+	static int ceph_read(CephMount mount, int fd, byte[] buf, long size, long offset) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_read(mount.c_ptr(), fd, buf, size, offset);
+	}
+
+	static int ceph_write(CephMount mount, int fd, byte[] buf, long size, long offset) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_write(mount.c_ptr(), fd, buf, size, offset);
+	}
+
+	static int ceph_get_file_stripe_unit(CephMount mount, int fd) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_get_file_stripe_unit(mount.c_ptr(), fd);
+	}
+
+	static int ceph_get_file_replication(CephMount mount, int fd) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_get_file_replication(mount.c_ptr(), fd);
+	}
+
+	static int ceph_set_default_file_stripe_unit(CephMount mount, int stripe_unit) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_set_default_file_stripe_unit(mount.c_ptr(), stripe_unit);
+	}
+
+	static int ceph_set_default_file_stripe_count(CephMount mount, int stripe_count) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_set_default_file_stripe_count(mount.c_ptr(), stripe_count);
+	}
+
+	static int ceph_set_default_object_size(CephMount mount, int object_size) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_set_default_object_size(mount.c_ptr(), object_size);
+	}
+
+	static int ceph_set_default_file_replication(CephMount mount, int replication) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_set_default_file_replication(mount.c_ptr(), replication);
+	}
+
+	static long ceph_lseek(CephMount mount, int fd, long offset, int whence) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_lseek(mount.c_ptr(), fd, offset, whence);
+	}
+
+	static int ceph_open(CephMount mount, String path, int flags, int mode) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_open(mount.c_ptr(), path, flags, mode);
+	}
+
+	static int ceph_chmod(CephMount mount, String path, int mode) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_chmod(mount.c_ptr(), path, mode);
+	}
+
+	static int ceph_lstat(CephMount mount, String path, CephStat stat) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_lstat(mount.c_ptr(), path, stat);
+	}
+
+	static int ceph_setattr(CephMount mount, String relpath, CephStat stat, int mask) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_setattr(mount.c_ptr(), relpath, stat, mask);
+	}
+
+	static int ceph_statfs(CephMount mount, String path, CephStatVFS statvfs) throws CephException {
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_statfs(mount.c_ptr(), path, statvfs);
+	}
+
+	static int ceph_opendir(CephMount mount, CephDirectory dir, String path) throws CephException {
+		dir.requireState(CephDirectory.State.PREPARING);
+		mount.requireState(CephMount.State.MOUNTED);
+		int ret = native_ceph_opendir(mount.c_ptr(), dir, path);
+		if (ret == 0)
+			dir.setState(CephDirectory.State.OPEN);
+		return ret;
+	}
+
+	static int ceph_closedir(CephMount mount, CephDirectory dir) throws CephException {
+		dir.requireState(CephDirectory.State.OPEN);
+		mount.requireState(CephMount.State.MOUNTED);
+		int ret = native_ceph_closedir(mount.c_ptr(), dir.c_ptr());
+		if (ret == 0)
+			dir.setState(CephDirectory.State.PREPARING);
+		return ret;
+	}
+
+	static int ceph_getdnames(CephMount mount, CephDirectory dir, byte[] buf, long len) throws CephException {
+		dir.requireState(CephDirectory.State.OPEN);
+		mount.requireState(CephMount.State.MOUNTED);
+		return native_ceph_getdnames(mount.c_ptr(), dir.c_ptr(), buf, len);
+	}
+
+
+	/*
+	 * Package-private: called from CephNativeLoader
+	 */
+	static native void native_initialize();
+
+	/*
+	 * Native methods. All access uses package-private methods above that
+	 * add basic state checks to help avoid bad pointers being sent to JNI.
+	 */
+	private	static native int native_ceph_create(CephMount mount, String root);
+	private	static native int native_ceph_mount(long mountp, String root);
+	private	static native void native_ceph_shutdown(long mountp);
+	private	static native int native_ceph_conf_set(long mountp, String option, String value);
+	private	static native int native_ceph_conf_get(long mountp, String option, byte[] buf, long len);
+	private	static native String native_ceph_getcwd(long mountp);
+	private	static native int native_ceph_conf_read_file(long mountp, String path);
+	private	static native int native_ceph_chdir(long mountp, String cwd);
+	private	static native int native_ceph_mkdirs(long mountp, String path, int mode);
+	private	static native int native_ceph_rmdir(long mountp, String path);
+	private	static native int native_ceph_unlink(long mountp, String path);
+	private	static native int native_ceph_rename(long mountp, String from, String to);
+	private	static native int native_ceph_close(long mountp, int fd);
+	private	static native int native_ceph_read(long mountp, int fd, byte[] buf, long size, long offset);
+	private	static native int native_ceph_write(long mountp, int fd, byte[] buf, long size, long offset);
+	private	static native int native_ceph_get_file_stripe_unit(long mountp, int fd);
+	private	static native int native_ceph_get_file_replication(long mountp, int fd);
+	private	static native int native_ceph_set_default_file_stripe_unit(long mountp, int stripe_unit);
+	private	static native int native_ceph_set_default_file_stripe_count(long mountp, int stripe_count);
+	private	static native int native_ceph_set_default_object_size(long mountp, int object_size);
+	private	static native int native_ceph_set_default_file_replication(long mountp, int replication);
+	private	static native long native_ceph_lseek(long mountp, int fd, long offset, int whence);
+	private	static native int native_ceph_open(long mountp, String path, int flags, int mode);
+	private	static native int native_ceph_chmod(long mountp, String path, int mode);
+	private	static native int native_ceph_lstat(long mountp, String path, CephStat stat);
+	private	static native int native_ceph_setattr(long mountp, String relpath, CephStat stat, int mask);
+	private	static native int native_ceph_statfs(long mountp, String path, CephStatVFS statvfs);
+	private	static native int native_ceph_opendir(long mountp, CephDirectory dir, String name);
+	private	static native int native_ceph_closedir(long mountp, long dirp);
+	private	static native int native_ceph_getdnames(long mountp, long dirp, byte[] buf, long len);
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephStat.java b/src/java/java/net/newdream/ceph/fs/CephStat.java
new file mode 100644
index 0000000..10faec1
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephStat.java
@@ -0,0 +1,15 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Holds struct stat fields.
+ */
+public class CephStat {
+	int mode;
+	int uid;
+	int gid;
+	long size;
+	long blksize;
+	long blocks;
+	long a_time;
+	long m_time;
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephStatVFS.java b/src/java/java/net/newdream/ceph/fs/CephStatVFS.java
new file mode 100644
index 0000000..f4a7287
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephStatVFS.java
@@ -0,0 +1,14 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Holds struct statvfs fields.
+ */
+public class CephStatVFS {
+	long bsize;
+	long frsize;
+	long blocks;
+	long bavail;
+	long files;
+	long fsid;
+	long namemax;
+}
diff --git a/src/java/java/net/newdream/ceph/fs/CephStruct.java b/src/java/java/net/newdream/ceph/fs/CephStruct.java
new file mode 100644
index 0000000..efea86d
--- /dev/null
+++ b/src/java/java/net/newdream/ceph/fs/CephStruct.java
@@ -0,0 +1,33 @@
+package net.newdream.ceph.fs;
+
+/**
+ * Basic handling of low-level Ceph structs.
+ *
+ * - Enforces state
+ * - Holds JNI C pointer (to be implemented)
+ */
+abstract class CephStruct<T extends Enum<T>> {
+	private T state;
+
+	CephStruct(T initState) {
+		state = initState;
+	}
+
+	void setState(T state) {
+		this.state = state;
+	}
+
+	void requireState(T ... states) throws CephException {
+		for (int i = 0; i < states.length; i++) {
+			if (this.state == states[i])
+				return;
+		}
+		String msg = "valid state(s):";
+		for (int i = 0; i < states.length; i++) {
+			msg += " " + states[i].name();
+			if (i < (states.length-1))
+				msg += ",";
+		}
+		throw new CephInvalidStateException(msg);
+	}
+}
diff --git a/src/java/native/libcephfs_jni.cc b/src/java/native/libcephfs_jni.cc
new file mode 100644
index 0000000..c5961de
--- /dev/null
+++ b/src/java/native/libcephfs_jni.cc
@@ -0,0 +1,1037 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <jni.h>
+
+#include <cephfs/libcephfs.h>
+
+#include "net_newdream_ceph_fs_CephProxy.h"
+
+#define CEPH_STAT_CP "net/newdream/ceph/fs/CephStat"
+#define CEPH_STAT_VFS_CP "net/newdream/ceph/fs/CephStatVFS"
+#define CEPH_MOUNT_CP "net/newdream/ceph/fs/CephMount"
+#define CEPH_CONSTANTS_CP "net/newdream/ceph/fs/CephConstants"
+#define CEPH_DIRECTORY_CP "net/newdream/ceph/fs/CephDirectory"
+
+/* Cached field IDs for net.newdream.ceph.fs.CephStat */
+static jfieldID cephstat_mode_fid;
+static jfieldID cephstat_uid_fid;
+static jfieldID cephstat_gid_fid;
+static jfieldID cephstat_size_fid;
+static jfieldID cephstat_blksize_fid;
+static jfieldID cephstat_blocks_fid;
+static jfieldID cephstat_a_time_fid;
+static jfieldID cephstat_m_time_fid;
+
+/* Cached field IDs for net.newdream.ceph.fs.CephStatVFS */
+static jfieldID cephstatvfs_bsize_fid;
+static jfieldID cephstatvfs_frsize_fid;
+static jfieldID cephstatvfs_blocks_fid;
+static jfieldID cephstatvfs_bavail_fid;
+static jfieldID cephstatvfs_files_fid;
+static jfieldID cephstatvfs_fsid_fid;
+static jfieldID cephstatvfs_namemax_fid;
+
+/* Cached field IDs for net.newdream.ceph.fs.CephMount */
+static jfieldID cephmount_instance_ptr_fid;
+
+/* Cached field IDs for net.newdream.ceph.fs.CephDirectory */
+static jfieldID cephdirectory_instance_ptr_fid;
+
+/*
+ * Exception throwing helper. Adapted from Apache Hadoop header
+ * org_apache_hadoop.h by adding the do {} while (0) construct.
+ */
+#define THROW(env, exception_name, message) \
+	do { \
+		jclass ecls = env->FindClass(exception_name); \
+		if (ecls) { \
+			int ret = env->ThrowNew(ecls, message); \
+			if (ret < 0) { \
+				printf("(CephFS) Fatal Error\n"); \
+			} \
+			env->DeleteLocalRef(ecls); \
+		} \
+	} while (0)
+
+
+static void cephThrowNullArg(JNIEnv *env, const char *msg)
+{
+	THROW(env, "java/lang/NullPointerException", msg);
+}
+
+static void cephThrowOutOfMemory(JNIEnv *env, const char *msg)
+{
+	THROW(env, "java/lang/OutOfMemoryException", msg);
+}
+
+static void cephThrowInternal(JNIEnv *env, const char *msg)
+{
+	THROW(env, "java/lang/InternalError", msg);
+}
+
+static void cephThrowIndexBounds(JNIEnv *env, const char *msg)
+{
+	THROW(env, "java/lang/IndexOutOfBoundsException", msg);
+}
+
+static void cephThrowIllegalArg(JNIEnv *env, const char *msg)
+{
+	THROW(env, "java/lang/IllegalArgumentException", msg);
+}
+
+#define CHECK_ARG_NULL(v, m, r) do { \
+	if (!(v)) { \
+		cephThrowNullArg(env, (m)); \
+		return (r); \
+	} } while (0)
+
+#define CHECK_ARG_COND(c, m, r) do { \
+	if ((c)) { \
+		cephThrowIllegalArg(env, (m)); \
+		return (r); \
+	} } while (0)
+
+#define CHECK_ARG_BOUNDS(c, m, r) do { \
+	if ((c)) { \
+		cephThrowIndexBounds(env, (m)); \
+		return (r); \
+	} } while (0)
+
+/*
+ * Initialize all the fields in CephConstants
+ */
+static int setup_constants(JNIEnv *env, jclass clz)
+{
+	jclass cephconstants_cls;
+	jfieldID fid;
+
+	cephconstants_cls = env->FindClass(CEPH_CONSTANTS_CP);
+	if (!cephconstants_cls)
+		return 1;
+
+#define JAVA_SET_CEPH_CONSTANT(val, fname) do { \
+		fid = env->GetStaticFieldID(cephconstants_cls, fname, "I"); \
+		if (!fid) \
+			return 1; \
+		env->SetStaticIntField(cephconstants_cls, fid, val); \
+	} while (0)
+
+	JAVA_SET_CEPH_CONSTANT(SEEK_SET, "SEEK_SET");
+	JAVA_SET_CEPH_CONSTANT(SEEK_CUR, "SEEK_CUR");
+	JAVA_SET_CEPH_CONSTANT(SEEK_END, "SEEK_END");
+
+	JAVA_SET_CEPH_CONSTANT(O_RDONLY, "O_RDONLY");
+	JAVA_SET_CEPH_CONSTANT(O_RDWR,   "O_RDWR");
+	JAVA_SET_CEPH_CONSTANT(O_APPEND, "O_APPEND");
+	JAVA_SET_CEPH_CONSTANT(O_CREAT,  "O_CREAT");
+	JAVA_SET_CEPH_CONSTANT(O_TRUNC,  "O_TRUNC");
+	JAVA_SET_CEPH_CONSTANT(O_EXCL,   "O_EXCL");
+
+	JAVA_SET_CEPH_CONSTANT(CEPH_SETATTR_MODE,  "SETATTR_MODE");
+	JAVA_SET_CEPH_CONSTANT(CEPH_SETATTR_UID,   "SETATTR_UID");
+	JAVA_SET_CEPH_CONSTANT(CEPH_SETATTR_GID,   "SETATTR_GID");
+	JAVA_SET_CEPH_CONSTANT(CEPH_SETATTR_MTIME, "SETATTR_MTIME");
+	JAVA_SET_CEPH_CONSTANT(CEPH_SETATTR_ATIME, "SETATTR_ATIME");
+
+	JAVA_SET_CEPH_CONSTANT(EINVAL,       "EINVAL");
+	JAVA_SET_CEPH_CONSTANT(ENOENT,       "ENOENT");
+	JAVA_SET_CEPH_CONSTANT(EEXIST,       "EEXIST");
+	JAVA_SET_CEPH_CONSTANT(ERANGE,       "ERANGE");
+	JAVA_SET_CEPH_CONSTANT(ENAMETOOLONG, "ENAMETOOLONG");
+
+#undef JAVA_SET_CEPH_CONSTANT
+
+	return 0;
+}
+
+/*
+ * Setup cached field IDs
+ */
+static int setup_field_ids(JNIEnv *env, jclass clz)
+{
+	jclass cephstat_cls;
+	jclass cephstatvfs_cls;
+	jclass cephmount_cls;
+	jclass cephdirectory_cls;
+
+#define GETFID(clz, field, type) do { \
+	clz ## _ ## field ## _fid = env->GetFieldID(clz ## _cls, #field, #type); \
+	if ( ! clz ## _ ## field ## _fid ) \
+		return 1; \
+	} while (0)
+
+	/* Cache CephStat fields */
+
+	cephstat_cls = env->FindClass(CEPH_STAT_CP);
+	if (!cephstat_cls)
+		return 1;
+
+	GETFID(cephstat, mode, I);
+	GETFID(cephstat, uid, I);
+	GETFID(cephstat, gid, I);
+	GETFID(cephstat, size, J);
+	GETFID(cephstat, blksize, J);
+	GETFID(cephstat, blocks, J);
+	GETFID(cephstat, a_time, J);
+	GETFID(cephstat, m_time, J);
+
+	/* Cache CephStatVFS fields */
+
+	cephstatvfs_cls = env->FindClass(CEPH_STAT_VFS_CP);
+	if (!cephstatvfs_cls)
+		return 1;
+
+	GETFID(cephstatvfs, bsize, J);
+	GETFID(cephstatvfs, frsize, J);
+	GETFID(cephstatvfs, blocks, J);
+	GETFID(cephstatvfs, bavail, J);
+	GETFID(cephstatvfs, files, J);
+	GETFID(cephstatvfs, fsid, J);
+	GETFID(cephstatvfs, namemax, J);
+
+#undef GETFID
+
+	/* Cache CephMount fields */
+
+	cephmount_cls = env->FindClass(CEPH_MOUNT_CP);
+	if (!cephmount_cls)
+		return 1;
+
+	cephmount_instance_ptr_fid = env->GetFieldID(cephmount_cls, "instance_ptr", "J");
+	if (!cephmount_instance_ptr_fid)
+		return 1;
+
+	/* Cache CephDirectory fields */
+
+	cephdirectory_cls = env->FindClass(CEPH_DIRECTORY_CP);
+	if (!cephdirectory_cls)
+		return 1;
+
+	cephdirectory_instance_ptr_fid = env->GetFieldID(cephdirectory_cls, "instance_ptr", "J");
+	if (!cephdirectory_instance_ptr_fid)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_initialize
+ * Signature: ()V
+ */
+JNIEXPORT void JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1initialize
+	(JNIEnv *env, jclass clz)
+{
+	if (setup_constants(env, clz))
+		return;
+
+	if (setup_field_ids(env, clz))
+		return;
+
+	return;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_create
+ * Signature: (Lnet/newdream/ceph/fs/CephMount;Ljava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1create
+	(JNIEnv *env, jclass clz, jobject j_cephmount, jstring j_id)
+{
+	struct ceph_mount_info *cmount;
+	const char *c_id = NULL;
+	int ret;
+
+	CHECK_ARG_NULL(j_cephmount, "@mount is null", -1);
+
+	if (j_id) {
+		c_id = env->GetStringUTFChars(j_id, NULL);
+		if (!c_id) {
+			cephThrowInternal(env, "Failed to pin memory");
+			return -1;
+		}
+	}
+
+	ret = ceph_create(&cmount, c_id);
+
+	if (c_id)
+		env->ReleaseStringUTFChars(j_id, c_id);
+
+	env->SetLongField(j_cephmount, cephmount_instance_ptr_fid, (long)cmount);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_mount
+ * Signature: (JLjava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1mount
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_root)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_root = NULL;
+	int ret;
+
+	if (j_root) {
+		c_root = env->GetStringUTFChars(j_root, NULL);
+		if (!c_root) {
+			cephThrowInternal(env, "Failed to pin memory");
+			return -1;
+		}
+	}
+
+	ret = ceph_mount(cmount, c_root);
+
+	if (c_root)
+		env->ReleaseStringUTFChars(j_root, c_root);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_shutdown
+ * Signature: (J)V
+ */
+JNIEXPORT void JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1shutdown
+	(JNIEnv *env, jclass clz, jlong j_mntp)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	
+	ceph_shutdown(cmount);
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_conf_set
+ * Signature: (JLjava/lang/String;Ljava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1conf_1set
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_opt, jstring j_val)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_opt, *c_val;
+	int ret;
+
+	CHECK_ARG_NULL(j_opt, "@option is null", -1);
+	CHECK_ARG_NULL(j_val, "@value is null", -1);
+
+	c_opt = env->GetStringUTFChars(j_opt, NULL);
+	if (!c_opt) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	c_val = env->GetStringUTFChars(j_val, NULL);
+	if (!c_val) {
+		env->ReleaseStringUTFChars(j_opt, c_opt);
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_conf_set(cmount, c_opt, c_val);
+
+	env->ReleaseStringUTFChars(j_opt, c_opt);
+	env->ReleaseStringUTFChars(j_val, c_val);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_conf_get
+ * Signature: (JLjava/lang/String;[BJ)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1conf_1get
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_opt, jbyteArray j_buf, jlong j_len)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_opt;
+	jsize buf_size;
+	jbyte *c_buf;
+	int ret;
+
+	CHECK_ARG_NULL(j_opt, "@option is null", -1);
+	CHECK_ARG_NULL(j_buf, "@buf is null", -1);
+	CHECK_ARG_BOUNDS(j_len < 0, "@len is negative", -1);
+
+	buf_size = env->GetArrayLength(j_buf);
+	CHECK_ARG_BOUNDS(j_len > buf_size, "@len > @buf.length", -1);
+
+	c_opt = env->GetStringUTFChars(j_opt, NULL);
+	if (!c_opt) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	c_buf = env->GetByteArrayElements(j_buf, NULL);
+	if (!c_buf) {
+		env->ReleaseStringUTFChars(j_opt, c_opt);
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_conf_get(cmount, c_opt, (char*)c_buf, (size_t)j_len);
+
+	env->ReleaseStringUTFChars(j_opt, c_opt);
+
+	env->ReleaseByteArrayElements(j_buf, c_buf, 0);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_getcwd
+ * Signature: (J)Ljava/lang/String;
+ */
+JNIEXPORT jstring JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1getcwd
+	(JNIEnv *env, jclass clz, jlong j_mntp)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_cwd;
+
+	c_cwd = ceph_getcwd(cmount);
+	if (!c_cwd) {
+		cephThrowOutOfMemory(env, "ceph_getcwd");
+		return NULL;
+	}
+
+	return env->NewStringUTF(c_cwd);
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_chdir
+ * Signature: (JLjava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1chdir
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_chdir(cmount, c_path);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_conf_read_file
+ * Signature: (JLjava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1conf_1read_1file
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_conf_read_file(cmount, c_path);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_mkdirs
+ * Signature: (JLjava/lang/String;I)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1mkdirs
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jint j_mode)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_mkdirs(cmount, c_path, (int)j_mode);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_rmdir
+ * Signature: (JLjava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1rmdir
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_rmdir(cmount, c_path);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_unlink
+ * Signature: (JLjava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1unlink
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_unlink(cmount, c_path);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_rename
+ * Signature: (JLjava/lang/String;Ljava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1rename
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_from, jstring j_to)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_from, *c_to;
+	int ret;
+
+	CHECK_ARG_NULL(j_from, "@from is null", -1);
+	CHECK_ARG_NULL(j_to, "@to is null", -1);
+
+	c_from = env->GetStringUTFChars(j_from, NULL);
+	if (!c_from) {
+		cephThrowInternal(env, "Failed to pin memory!");
+		return -1;
+	}
+
+	c_to = env->GetStringUTFChars(j_to, NULL);
+	if (!c_to) {
+		env->ReleaseStringUTFChars(j_from, c_from);
+		cephThrowInternal(env, "Failed to pin memory.");
+		return -1;
+	}
+
+	ret = ceph_rename(cmount, c_from, c_to);
+
+	env->ReleaseStringUTFChars(j_from, c_from);
+	env->ReleaseStringUTFChars(j_to, c_to);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_close
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1close
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_close(cmount, (int)j_fd);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_read
+ * Signature: (JI[BJJ)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1read
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd, jbyteArray j_buf, jlong j_size, jlong j_offset)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	jsize buf_size;
+	jbyte *c_buf;
+	int ret;
+
+	CHECK_ARG_NULL(j_buf, "@buf is null", -1);
+	CHECK_ARG_BOUNDS(j_size < 0, "@size is negative", -1);
+
+	buf_size = env->GetArrayLength(j_buf);
+	CHECK_ARG_BOUNDS(j_size > buf_size, "@size > @buf.length", -1);
+
+	c_buf = env->GetByteArrayElements(j_buf, NULL);
+	if (!c_buf) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_read(cmount, (int)j_fd, (char*)c_buf, (int)j_size, (int)j_offset);
+
+	env->ReleaseByteArrayElements(j_buf, c_buf, 0);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_write
+ * Signature: (JI[BJJ)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1write
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd, jbyteArray j_buf, jlong j_size, jlong j_offset)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	jsize buf_size;
+	jbyte *c_buf;
+	int ret;
+
+	CHECK_ARG_NULL(j_buf, "@buf is null", -1);
+	CHECK_ARG_BOUNDS(j_size < 0, "@size is negative", -1);
+
+	buf_size = env->GetArrayLength(j_buf);
+	CHECK_ARG_BOUNDS(j_size > buf_size, "@size > @buf.length", -1);
+
+	c_buf = env->GetByteArrayElements(j_buf, NULL);
+	if (!c_buf) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_write(cmount, (int)j_fd, (char*)c_buf, (int)j_size, (int)j_offset);
+
+	env->ReleaseByteArrayElements(j_buf, c_buf, JNI_ABORT);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_get_file_stripe_unit
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1get_1file_1stripe_1unit
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_get_file_stripe_unit(cmount, (int)j_fd);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_get_file_replication
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1get_1file_1replication
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_get_file_replication(cmount, (int)j_fd);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_set_default_file_stripe_unit
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1set_1default_1file_1stripe_1unit
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_stripe_unit)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_set_default_file_stripe_unit(cmount, (int)j_stripe_unit);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_set_default_file_stripe_count
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1set_1default_1file_1stripe_1count
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_stripe_count)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_set_default_file_stripe_count(cmount, (int)j_stripe_count);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_set_default_object_size
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1set_1default_1object_1size
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_object_size)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_set_default_object_size(cmount, (int)j_object_size);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_set_default_file_replication
+ * Signature: (JI)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1set_1default_1file_1replication
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_replication)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	int ret;
+
+	ret = ceph_set_default_file_replication(cmount, (int)j_replication);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_lseek
+ * Signature: (JIJI)J
+ */
+JNIEXPORT jlong JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1lseek
+	(JNIEnv *env, jclass clz, jlong j_mntp, jint j_fd, jlong j_offset, jint j_whence)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+
+	switch ((int)j_whence) {
+	case SEEK_SET:
+	case SEEK_CUR:
+	case SEEK_END:
+		break;
+	default:
+		cephThrowIllegalArg(env, "Unknown whence value");
+		return -1;
+	}
+
+	return ceph_lseek(cmount, (int)j_fd, (long)j_offset, (int)j_whence);
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_open
+ * Signature: (JLjava/lang/String;II)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1open
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jint j_flags, jint j_mode)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "Failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_open(cmount, c_path, (int)j_flags, (int)j_mode);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_chmod
+ * Signature: (JLjava/lang/String;I)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1chmod
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jint j_mode)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "Failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_chmod(cmount, c_path, (int)j_mode);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_lstat
+ * Signature: (JLjava/lang/String;Lnet/newdream/ceph/fs/CephStat;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1lstat
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jobject j_cephstat)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	long long time;
+	struct stat st;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+	CHECK_ARG_NULL(j_cephstat, "@stat is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "Failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_lstat(cmount, c_path, &st);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	if (ret < 0)
+		return ret;
+
+	env->SetIntField(j_cephstat, cephstat_mode_fid, st.st_mode);
+	env->SetIntField(j_cephstat, cephstat_uid_fid, st.st_uid);
+	env->SetIntField(j_cephstat, cephstat_gid_fid, st.st_gid);
+	env->SetLongField(j_cephstat, cephstat_size_fid, st.st_size);
+	env->SetLongField(j_cephstat, cephstat_blksize_fid, st.st_blksize);
+	env->SetLongField(j_cephstat, cephstat_blocks_fid, st.st_blocks);
+
+	time = st.st_mtim.tv_sec;
+	time *= 1000;
+	time += st.st_mtim.tv_nsec / 1000;
+	env->SetLongField(j_cephstat, cephstat_m_time_fid, time);
+
+	time = st.st_atim.tv_sec;
+	time *= 1000;
+	time += st.st_atim.tv_nsec / 1000;
+	env->SetLongField(j_cephstat, cephstat_a_time_fid, time);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_setattr
+ * Signature: (JLjava/lang/String;Lnet/newdream/ceph/fs/CephStat;I)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1setattr
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jobject j_cephstat, jint j_mask)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	struct stat st;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+	CHECK_ARG_NULL(j_cephstat, "@stat is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "Failed to pin memory");
+		return -1;
+	}
+
+	memset(&st, 0, sizeof(st));
+
+	st.st_mode = env->GetIntField(j_cephstat, cephstat_mode_fid);
+	st.st_uid = env->GetIntField(j_cephstat, cephstat_uid_fid);
+	st.st_gid = env->GetIntField(j_cephstat, cephstat_gid_fid);
+	st.st_mtime = env->GetIntField(j_cephstat, cephstat_m_time_fid);
+	st.st_atime = env->GetIntField(j_cephstat, cephstat_a_time_fid);
+
+	ret = ceph_setattr(cmount, c_path, &st, (int)j_mask);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_statfs
+ * Signature: (JLjava/lang/String;Lnet/newdream/ceph/fs/CephStatVFS;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1statfs
+	(JNIEnv *env, jclass clz, jlong j_mntp, jstring j_path, jobject j_cephstatvfs)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	const char *c_path;
+	struct statvfs st;
+	int ret;
+
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+	CHECK_ARG_NULL(j_cephstatvfs, "@stat is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "Failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_statfs(cmount, c_path, &st);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	if (ret < 0)
+		return ret;
+
+	env->SetLongField(j_cephstatvfs, cephstatvfs_bsize_fid, st.f_bsize);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_frsize_fid, st.f_frsize);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_blocks_fid, st.f_blocks);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_bavail_fid, st.f_bavail);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_files_fid, st.f_files);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_fsid_fid, st.f_fsid);
+	env->SetLongField(j_cephstatvfs, cephstatvfs_namemax_fid, st.f_namemax);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_opendir
+ * Signature: (JLnet/newdream/ceph/fs/CephDirectory;Ljava/lang/String;)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1opendir
+	(JNIEnv *env, jclass clz, jlong j_mntp, jobject j_cephdirectory, jstring j_path)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	struct ceph_dir_result *dirp;
+	const char *c_path;
+	int ret;
+
+	CHECK_ARG_NULL(j_cephdirectory, "@dir is null", -1);
+	CHECK_ARG_NULL(j_path, "@path is null", -1);
+
+	c_path = env->GetStringUTFChars(j_path, NULL);
+	if (!c_path) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_opendir(cmount, c_path, &dirp);
+
+	env->ReleaseStringUTFChars(j_path, c_path);
+
+	env->SetLongField(j_cephdirectory, cephdirectory_instance_ptr_fid, (long)dirp);
+
+	return ret;
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_closedir
+ * Signature: (JJ)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1closedir
+	(JNIEnv *env, jclass clz, jlong j_mntp, jlong j_dirp)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	struct ceph_dir_result *dirp = (struct ceph_dir_result *)j_dirp;
+
+	return ceph_closedir(cmount, dirp);
+}
+
+/*
+ * Class:     net_newdream_ceph_fs_CephProxy
+ * Method:    native_ceph_getdnames
+ * Signature: (JJ[BJ)I
+ */
+JNIEXPORT jint JNICALL Java_net_newdream_ceph_fs_CephProxy_native_1ceph_1getdnames
+	(JNIEnv *env, jclass clz, jlong j_mntp, jlong j_dirp, jbyteArray j_buf, jlong j_len)
+{
+	struct ceph_mount_info *cmount = (struct ceph_mount_info *)j_mntp;
+	struct ceph_dir_result *dirp = (struct ceph_dir_result *)j_dirp;
+	jsize buf_size;
+	jbyte *c_buf;
+	int ret;
+
+	CHECK_ARG_NULL(j_buf, "@buf is null", -1);
+	CHECK_ARG_BOUNDS(j_len < 0, "@len is negative", -1);
+
+	buf_size = env->GetArrayLength(j_buf);
+	CHECK_ARG_BOUNDS(j_len > buf_size, "@len > @buf.length", -1);
+
+	c_buf = env->GetByteArrayElements(j_buf, NULL);
+	if (!c_buf) {
+		cephThrowInternal(env, "failed to pin memory");
+		return -1;
+	}
+
+	ret = ceph_getdnames(cmount, dirp, (char*)c_buf, (int)j_len);
+
+	env->ReleaseByteArrayElements(j_buf, c_buf, 0);
+
+	return ret;
+}
diff --git a/src/java/test/CephMountCreateTest.java b/src/java/test/CephMountCreateTest.java
new file mode 100644
index 0000000..76a3197
--- /dev/null
+++ b/src/java/test/CephMountCreateTest.java
@@ -0,0 +1,76 @@
+import org.junit.*;
+import static org.junit.Assert.*;
+
+import net.newdream.ceph.fs.*;
+
+/*
+ * This tests the mount root dir functionality. It creates an empty
+ * directory in the real root, then it re-mounts the file system
+ * with the empty directory specified as the root. Assertions are
+ * that the "/" in the normal mount is non-empty, and that "/" is
+ * empty in the mount with the empty directory as the root.
+ */
+public class CephMountCreateTest {
+
+	private static String conf_file;
+	
+	@BeforeClass
+	public static void class_setup() throws CephException {
+		conf_file = System.getProperty("CEPH_CONF_FILE");
+	}
+
+	private CephMount setupMount(String root) throws CephException {
+		CephMount mount = new CephMount();
+		if (conf_file != null)
+			mount.conf_read_file(conf_file);
+		if (root == null)
+			mount.mount();
+		else
+			mount.mount(root);
+		return mount;
+	}
+
+	@Test
+	public void test_CephMountCreate() throws CephException {
+		CephMount mount;
+		boolean found;
+
+		/* root dir has more than one dir */
+		System.out.println("Check real root for empty dir");
+		mount = setupMount(null);
+
+		mount.rmdir("/libcephfs_java_test_dir");
+		mount.mkdirs("/libcephfs_java_test_dir", 777);
+		CephDirectory dir = mount.opendir("/");
+		String[] subdirs = dir.getdnames();
+		dir.close();
+		found = false;
+		for (String d : subdirs) {
+			if (d.compareTo("libcephfs_java_test_dir") == 0)
+				found = true;
+		}
+		assertTrue(found);
+		mount.shutdown();
+
+		/* changing root to empty dir */
+		System.out.println("Check that new root is empty");
+		mount = setupMount("/libcephfs_java_test_dir");
+
+		dir = mount.opendir("/");
+		subdirs = dir.getdnames();
+		dir.close();
+		found = false;
+		for (String d : subdirs) {
+			if (d.compareTo(".") != 0 && d.compareTo("..") != 0)
+				found = true;
+		}
+		assertFalse(found);
+		mount.shutdown();
+
+		/* cleanup */
+		System.out.println("Cleanup");
+		mount = setupMount(null);
+		mount.rmdir("/libcephfs_java_test_dir");
+		mount.shutdown();
+	}
+}
diff --git a/src/java/test/CephMountTest.java b/src/java/test/CephMountTest.java
new file mode 100644
index 0000000..8ab7111
--- /dev/null
+++ b/src/java/test/CephMountTest.java
@@ -0,0 +1,72 @@
+import org.junit.*;
+import static org.junit.Assert.*;
+
+import net.newdream.ceph.fs.*;
+
+public class CephMountTest {
+
+	private static CephMount mount;
+	private static String priv_dir = "/libcephfs_java_test_dir";
+
+    @BeforeClass
+    public static void setup() throws CephException {
+		mount = new CephMount();
+
+		System.out.println("Connecting");
+
+		String conf_file = System.getProperty("CEPH_CONF_FILE");
+		if (conf_file != null)
+			mount.conf_read_file(conf_file);
+
+		mount.mount();
+
+		mount.rmdir(priv_dir);
+		mount.mkdirs(priv_dir, 777);
+    }
+
+    @AfterClass
+    public static void destroy() throws CephException {
+		System.out.println("Shutting down");
+		mount.rmdir(priv_dir);
+		mount.shutdown();
+    }
+
+    @Test
+    public void test_ConfigOption() throws CephException {
+        String opt = "log to stderr";
+        String val1, val2;
+
+        /* set option to 2 and check that it set */
+        val1 = "false";
+        mount.conf_set(opt, val1);
+        val2 = mount.conf_get(opt, 1);
+        assertTrue(val1.compareTo(val2) == 0);
+		
+        /* make sure the option wasn't already 2 */
+        val1 = "true";
+        mount.conf_set(opt, val1);
+        val2 = mount.conf_get(opt);
+        assertTrue(val1.compareTo(val2) == 0);
+    }
+
+	@Test
+	public void test_getcwd() throws CephException {
+		String d1 = "/";
+		String cwd;
+
+		mount.chdir(d1);
+		cwd = mount.getcwd();
+		assert(cwd.compareTo(d1) == 0);
+
+		mount.chdir(priv_dir);
+		cwd = mount.getcwd();
+		assert(cwd.compareTo(priv_dir) == 0);
+	}
+
+	@Test
+	public void test_CephDirectory() throws CephException {
+		CephDirectory dir = mount.opendir("/");
+		String[] subdirs = dir.getdnames(1);
+		dir.close();
+	}
+}
-- 
1.7.5.4

